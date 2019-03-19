DIR = .
PURS    = $(DIR)/purs
ZEPHYR  = $(DIR)/zephyr
SPAGO   = $(DIR)/spago
PSCPKG  = $(DIR)/pscpkg
PURP    = $(DIR)/purp
PSC2NIX = $(DIR)/pscpkg2nix

PS_LATEST = $(PURS)/github.release.latest
ZP_LATEST = $(ZEPHYR)/github.release.latest
SP_LATEST = $(SPAGO)/github.release.latest
PP_LATEST = $(PSCPKG)/github.release.latest
PN_GITHUB = $(PSC2NIX)/github
PU_GITHUB = $(PURP)/github

.PHONY : shell-dev
shell-dev :
	# nix-shell -p jq shab
	nix-shell ./make-shell.nix

$(PS_LATEST).json : $(PS_LATEST).sh
	sh $< > $@

$(PS_LATEST).prefetched.json : $(PS_LATEST).json $(PURS)/release.nix
	nix eval "(import $(PURS)/release.nix).assets" --json | shab | jq -r > $@

$(ZP_LATEST).json : $(ZP_LATEST).sh
	sh $< > $@

$(ZP_LATEST).prefetched.json : $(ZP_LATEST).json $(ZEPHYR)/release.nix
	nix eval "(import $(ZEPHYR)/release.nix).assets" --json | shab | jq -r > $@

$(SP_LATEST).json : $(SP_LATEST).sh
	sh $< > $@

$(SP_LATEST).prefetched.json : $(SP_LATEST).json $(SPAGO)/release.nix
	nix eval "(import $(SPAGO)/release.nix).assets" --json | shab | jq -r > $@

$(PP_LATEST).json : $(PP_LATEST).sh
	sh $< > $@

$(PP_LATEST).prefetched.json : $(PP_LATEST).json $(PSCPKG)/release.nix
	nix eval "(import $(PSCPKG)/release.nix).assets" --json | shab | jq -r > $@

.PHONY : $(PU_GITHUB).json
$(PU_GITHUB).json :
	env owner=justinwoo repo=purp ./common/github-prefetch.sh $< > $@

.PHONY : $(PN_GITHUB).json
$(PN_GITHUB).json :
	env owner=justinwoo repo=psc-package2nix ./common/github-prefetch.sh $< > $@
	# sh $< > $@

# OLD (but kept for the time being...)
# Switched from jq (below) to nix eval for better consistency
# $(SRC_URL)/%.github.release.linux.json : $(SRC_URL)/%.github.release.json
# 	jq '{ name, tag_name, created_at, "assets": [ .assets[] | select(.name | contains("linux") and contains("tar")) | { name, url: .browser_download_url, sha256: ("$$(nix-prefetch-url " + .browser_download_url +")") } ] }' $< | shab > $@
