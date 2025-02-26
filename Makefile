# Makefile for organizing files by year

# Configuration
SHELL := /bin/bash
SOURCE_DIR := .
DEST_BASE_DIR := organized_files

# Get list of all years from file modification times
YEARS := $(shell find $(SOURCE_DIR) -type f -printf "%TY\n" | sort -u)

.PHONY: all clean organize

all: organize

# Create year directories and organize files
organize: create_dirs
	@for year in $(YEARS); do \
		echo "Processing files from $$year..."; \
		find $(SOURCE_DIR) -type f -printf "%TY %p\n" | \
		awk -v year=$$year '$$1 == year {print $$2}' | \
		while read -r file; do \
			filename=$$(basename "$$file"); \
			sha256=$$(sha256sum "$$file" | cut -d' ' -f1); \
			if ! grep -q "$$sha256" "$(DEST_BASE_DIR)/$$year/.checksums" 2>/dev/null; then \
				cp "$$file" "$(DEST_BASE_DIR)/$$year/$$filename"; \
				echo "$$sha256  $$filename" >> "$(DEST_BASE_DIR)/$$year/.checksums"; \
				echo "Copied: $$filename -> $$year/"; \
			else \
				echo "Skipping duplicate: $$filename"; \
			fi \
		done; \
	done

# Create destination directories for each year
create_dirs:
	@for year in $(YEARS); do \
		mkdir -p "$(DEST_BASE_DIR)/$$year"; \
		touch "$(DEST_BASE_DIR)/$$year/.checksums"; \
	done

# Clean up organized files
clean:
	@echo "Cleaning up organized files..."
	@rm -rf $(DEST_BASE_DIR)