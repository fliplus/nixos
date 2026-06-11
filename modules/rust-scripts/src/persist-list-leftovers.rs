use std::{path::Path, process::Command};

fn main() {
    let persist_list = Command::new("persist-list")
        .output()
        .expect("Failed to execute command 'persist-list'");
    let output = String::from_utf8_lossy(&persist_list.stdout);

    let persist_paths: Vec<String> = output
        .lines()
        .filter(|line| !line.is_empty())
        .map(|line| format!("/persist{}", line.trim_end_matches('/')))
        .collect();

    let leftovers = find_leftovers(Path::new("/persist"), &persist_paths);

    for leftover in leftovers {
        println!("{leftover}");
    }
}

fn find_leftovers(directory: &Path, persist_paths: &[String]) -> Vec<String> {
    let mut leftovers = Vec::new();

    if let Ok(entries) = std::fs::read_dir(directory) {
        for entry in entries {
            if let Ok(entry) = entry {
                let path = entry.path();
                let path_str = path.display().to_string();

                if path.is_symlink() {
                    continue;
                }

                if persist_paths.iter().any(|p| { p.starts_with(&path_str) || path_str.starts_with(p) }) {
                    if path.is_dir() {
                        leftovers.extend(find_leftovers(&path, persist_paths));
                    }
                    continue
                }

                leftovers.push(path_str);
            }
        }
    }

    leftovers
}
