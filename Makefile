all:
	cabal v1-install optparse-applicative random
	ghc -O taporwave.hs
	@if [[ -x /usr/bin/upx ]]; then\
		upx --best ./taporwave;\
	else\
		echo 'Upx not found, skipping minification';\
	fi
