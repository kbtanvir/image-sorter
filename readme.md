Here’s a GitHub `README.md` content for your project:

---

# File Organizer by Year

A simple tool to organize images based on their last modified date. Inspired by Google Photos, this tool helps sort and deduplicate images, especially useful for managing backups and large collections.

## Features

- **Year-based organization**: Files are organized into directories named after their modification year.
- **Duplicate detection**: Files are checked for duplicates using SHA-256 checksums to avoid unnecessary copying.
- **Automation**: The entire process is automated using a `Makefile`, making it easy to run and integrate into workflows.
- **Customizable**: You can configure the source and destination directories to suit your needs.

## Usage

### Prerequisites

- A Unix-like operating system (Linux, macOS, etc.).
- `bash`, `find`, `awk`, `sha256sum`, and other standard Unix utilities.

### Steps

1. **Clone the repository** (if applicable):
   ```bash
   git clone https://github.com/kbtanvir/image-sorter.git
   cd image-sorter
   ```

2. **Place your files** in the source directory (default is the current directory `.`).

3. **Run the `Makefile`**:
   ```bash
   make all
   ```
   This will:
   - Create year-based directories inside the `organized_files` folder.
   - Copy files into their respective year directories.
   - Skip duplicate files based on their SHA-256 checksum.

4. **Clean up** (optional):
   To remove the organized files and directories, run:
   ```bash
   make clean
   ```

### Configuration

You can customize the following variables in the `Makefile`:

- `SOURCE_DIR`: The directory containing the files to organize (default is `.`).
- `DEST_BASE_DIR`: The base directory where organized files will be stored (default is `organized_files`).

Example:
```makefile
SOURCE_DIR := ./my_files
DEST_BASE_DIR := ./sorted_files
```

## How It Works

1. **Year Extraction**:
   - The `find` command extracts the modification year of each file.
   - A list of unique years is generated.

2. **Directory Creation**:
   - For each year, a directory is created inside the `DEST_BASE_DIR`.

3. **File Copying**:
   - Files are copied into their respective year directories.
   - SHA-256 checksums are used to detect and skip duplicate files.

4. **Checksum Tracking**:
   - A `.checksums` file is maintained in each year directory to track copied files and their checksums.

## Example

Given the following files in the source directory:
```
file1.txt (modified in 2021)
file2.jpg (modified in 2022)
file3.pdf (modified in 2021)
```

Running `make all` will create:
```
organized_files/
├── 2021/
│   ├── file1.txt
│   ├── file3.pdf
│   └── .checksums
└── 2022/
    ├── file2.jpg
    └── .checksums
```

## License

This project is open-source and available under the [MIT License](LICENSE).