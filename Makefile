PKG_FILES = functions.sh gist.sh icon.png info.plist kudos.plist setup.sh

test:
	@bash test.sh

pkg:
	@mkdir pkg 2>/dev/null
	@zip -q pkg/Gist.extension $(PKG_FILES)
