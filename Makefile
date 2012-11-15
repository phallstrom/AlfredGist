PKG_FILES = functions.sh gist.sh icon.png info.plist kudos.plist setup.sh update.xml
EXTENSION = Gist.alfredextension
INSTALL_DIR = $(HOME)/Library/Application Support/Alfred/extensions/scripts/Gist

all: $(EXTENSION)

$(EXTENSION): $(PKG_FILES) 
	zip -vT Gist.alfredextension $(PKG_FILES)

clean:
	rm -rf $(EXTENSION)

test:
	@roundup tests/test_*

local-install:
	cp $(PKG_FILES) "$(INSTALL_DIR)/"

