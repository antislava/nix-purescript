walk(if type == "object" then with_entries(select(.key != "download_count")) else . end)
