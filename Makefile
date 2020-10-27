define delete-file
	$(if $(filter $(platform),Windows),\
		del /f /q "$(1)" > NUL 2>&1 || exit 0,\
		$(RM) "$(1)")
endef

ifeq ($(OS),Windows_NT)
	platform := Windows
	settings := $(USERPROFILE)\.ideavimrc
else
	kernel   := $(shell uname -s)
	settings := $(HOME)/.ideavimrc

	ifeq ($(kernel),Darwin)
		platform := macOS
	else
		platform := Linux
	endif
endif

.PHONY: all
all: install

.PHONY:
clean:
	@$(call delete-file,$(settings))

.PHONY: install
install: $(settings)

ifeq ($(platform),Windows)
$(settings): install.ps1 ideavimrc
	@powershell -ExecutionPolicy ByPass -File "$(<)"
else
$(settings): ideavimrc
	@ln $(if $(filter $(platform),macOS),-h,) "$(<)" "$(@)"
endif
