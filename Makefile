DIR = .
PURS    = $(DIR)/purs
ZEPHYR  = $(DIR)/zephyr
SPAGO   = $(DIR)/spago
PSCPKG  = $(DIR)/pscpkg
PURP    = $(DIR)/purp
PSC2NIX = $(DIR)/pscpkg2nix

LATEST = github.release.latest

# NIX SHELLS

.PHONY : shell-dev
shell-dev :
	# nix-shell -p jq shab
	nix-shell ./make-shell.nix

.PHONY : shell-test
shell-test :
	nix-shell ./test-shell.nix


# PACKAGES WITH RELEASES

%.original.json : %.sh
	sh $< > $@

%.clean.json : %.original.json
	jq -r -f ./common/clean.jq $< > $@

# Adding dummy specifications so that shell completion works ;)
$(PURS)/$(LATEST).prefetched.json :

$(SPAGO)/$(LATEST).prefetched.json :

$(PSCPKG)/$(LATEST).prefetched.json :

$(ZEPHYR)/$(LATEST).prefetched.json :

# Generic rule
# %/$(LATEST).prefetched.json : %/$(LATEST).clean.json %/release.nix
# 	nix eval "(import $*/release.nix).assets" --json | shab | jq -r > $@

%/$(LATEST).prefetched.json : %/$(LATEST).clean.json
	nix eval "(import ./common/release.nix $<).assets" --json | shab | jq -r > $@


# PLAIN PACKAGES

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
