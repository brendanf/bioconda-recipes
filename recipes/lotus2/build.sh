#!/bin/sh
SHARE_DIR=$PREFIX/share/$PKG_NAME-$PKG_VERSION-$PKG_BUILDNUM

rm -rf bin/installs/ bin/lambda3* bin/LCA bin/rtk bin/sdm bin/vsearch
# Configure LotuS2
cp configs/LotuS.cfg.def lOTUs.cfg
for binary in blastn clustalo lambda3 LCA mafft minimap2 rtk sdm swarm usearch vsearch; do
    sed -i.bak -e "s|^$binary[[:space:]].*|$binary $PREFIX/bin/$binary|" lOTUs.cfg
done
for binary in cd-hit fasttree hmmsearch iqtree itsx makeBlastDB RDPjar; do
    sed -i.bak -e "s|^$binary[[:space:]]\(.*\)|$binary $PREFIX/bin/\1|" lOTUs.cfg
done
# Install
mkdir -p "$SHARE_DIR"
cp -R * "$SHARE_DIR/"

# install LotuS2 wrapper
mkdir -p "${PREFIX}/bin"
ln -s "${SHARE_DIR}/lotus2" "${PREFIX}/bin/"
