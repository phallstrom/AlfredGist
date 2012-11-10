PKG_FILES = functions.sh gist.sh icon.png info.plist kudos.plist setup.sh
INSTALL_DIR = $(HOME)/Library/Application Support/Alfred/extensions/scripts/Gist

test:
	@bash test.sh

clean:
	@rm -rf pkg

pkg:
	@mkdir pkg 2>/dev/null
	@zip -q pkg/Gist.alfredextension $(PKG_FILES)

install:
	cp $(PKG_FILES) "$(INSTALL_DIR)/"
