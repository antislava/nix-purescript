# EXAMPLE USAGE:
# env owner=justinwoo repo=purp ./common/github-prefetch.sh
export branch=`basename $rev || echo ""`
uri=https://github.com/$owner/$repo
nix-prefetch-git $uri --rev $rev \
  | jq '{ owner:"$owner", repo:"$repo", branch:"$branch", rev, sha256 }' \
  | shab \
  | jq 'with_entries(select(.value != ""))' -r
