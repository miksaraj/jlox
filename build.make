# Makefile for building a single directory of Java source files. It requires
# a PACKAGE variable to be set.

BUILD_DIR := build

SOURCES := $(wildcard $(PACKAGE)/*.java)
CLASSES := $(addprefix $(BUILD_DIR)/, $(SOURCES:.java=.class))

JAVA_OPTIONS := -Werror

default: $(CLASSES)
	@: # Don't show "Nothing to be done" output.

# Compile a single .java file to .class.
$(BUILD_DIR)/$(PACKAGE)/%.class: $(PACKAGE)/%.java
	@ mkdir -p $(BUILD_DIR)/$(PACKAGE)
	@ javac -cp $(DIR) -d $(BUILD_DIR)/$(PACKAGE) $(JAVA_OPTIONS) -implicit:none $<
	@ printf "%8s %-60s %s\n" javac $< "$(JAVA_OPTIONS)"

.PHONY: default