SOURCE_FILES = functions.sh gist.sh icon.png info.plist kudos.plist setup.sh
PKG_FILES = $(SOURCE_FILES) update.xml
EXTENSION = Gist.alfredextension
INSTALL_DIR = $(HOME)/Library/Application Support/Alfred/extensions/scripts/Gist
VERSION = 1.3
COMMENTS = Better JSON support for tabs and carriage returns causing errors.

all: $(EXTENSION)

$(EXTENSION): $(SOURCE_FILES) VERSION
	zip -T Gist.alfredextension $(PKG_FILES)

VERSION:
	sed -i '' -e "s/^# Version: .*/# Version: $(VERSION)/" info.plist
	sed -i '' -e "s#<version>.*</version>#<version>$(VERSION)</version>#" update.xml
	sed -i '' -e "s#<version>.*</version>#<version>$(VERSION)</version>#" latest.xml
	sed -i '' -e "s#<comments>.*</comments>#<comments>$(COMMENTS)</comments>#" latest.xml

clean:
	rm -rf $(EXTENSION)

test:
	@roundup tests/test_*

local-install:
	cp $(PKG_FILES) "$(INSTALL_DIR)/"

