# Distributed under the terms of the GNU General Public License v2

EAPI=5

DESCRIPTION="Funtoo's configuration tool: ego, epro."
HOMEPAGE="http://www.funtoo.org/Package:Ego"

GITHUB_REPO="$PN"
GITHUB_USER="funtoo"
GITHUB_TAG="${PV}"

if [ ${PV} == "9999" ] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/antematherian/${PN}.git"
else
	SRC_URI="https://www.github.com/${GITHUB_USER}/${GITHUB_REPO}/tarball/${GITHUB_TAG} -> ${PN}-${GITHUB_TAG}.tar.gz"
	RESTRICT="mirror"
	KEYWORDS="*"
fi

LICENSE="GPL-2"
SLOT="0"
IUSE=""
DEPEND=""
RDEPEND="=dev-lang/python-3*"

src_unpack() {

	if [ ${PV} == "9999" ] ; then
		git-r3_src_unpack
	else
		unpack ${A}
		mv "${WORKDIR}/${GITHUB_USER}-${PN}"-??????? "${S}" || die
	fi
}

src_install() {
	exeinto /usr/share/ego/modules
	doexe $S/modules/*
	insinto /usr/share/ego/modules-info
	doins $S/modules-info/*
	dobin $S/ego
	dosym ../share/ego/modules/profile.ego /usr/sbin/epro
	doman ego.1 epro.1
}
