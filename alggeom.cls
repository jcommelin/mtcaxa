%%
%% This is file `alggeom.cls',
%% LaTeX2e document class for the journal `Algebraic Geometry':
%%
%% A minimal modification of `compositio.cls' v1.5 (22 February 2013).
%% Copyright (c) 2002 London Mathematical Society
%% Based on `jcm.dtx' [Copyright (c) 1997 David Carlisle]
%% with substantial alterations by Fran Burstall and
%% permission from David Carlisle.
%%
%% The London Mathematical Society retains the right to distribute
%% and make available these macros. Permission is granted to an
%% author or a group of authors preparing a joint work for
%% publication in "Algebraic Geometry" to copy these macros
%% for their personal use only. No modifications are permitted.
%% The incorporation of any part of these macros, whether
%% in original or altered form, into any file or software carrying a
%% name other than "alggeom" or for the purpose of preparing
%% contributions in any medium to any publication other than
%% "Algebraic Geometry" is prohibited without special permission,
%% requests for which should be directed to production@lms.ac.uk
%%
%% Bugs may be reported to
%%    production@lms.ac.uk
%%
\NeedsTeXFormat{LaTeX2e}[1995/06/01]
\ProvidesClass{alggeom}
          [2013/02/22 v1.0b Algebraic Geometry class (OT)]

\def\CPM@err#1{\ClassError{alggeom}{#1}\@eha}
\def\CPM@warn#1{\ClassWarning{alggeom}{#1}}
\newif\if@final
\@finalfalse
\newif\if@draft
\@draftfalse
\newif\if@proofqedboxes
\@proofqedboxestrue
\newif\if@CPMams
\@CPMamstrue
\newif\if@ccby
\@ccbyfalse
\newif\if@links
\@linksfalse
\newif\if@print
\@printfalse

\DeclareOption{10pt}{\CPM@warn{11pt used (not optional)}}
\DeclareOption{11pt}{}
\DeclareOption{12pt}{\CPM@warn{11pt used (not optional)}}
\DeclareOption{oneside}{\CPM@warn{twoside used (not optional)}}
\DeclareOption{twoside}{}
\DeclareOption{twocolumn}{\CPM@warn{onecolumn used (not optional)}}
\DeclareOption{onecolumn}{}
\DeclareOption{a4paper}{\CPM@warn{Paper size option ignored}}
\DeclareOption{letterpaper}{\CPM@warn{Paper size option ignored}}

\DeclareOption{noboxes}{\@proofqedboxesfalse}
\DeclareOption{draft}{\@finalfalse\@drafttrue\setlength\overfullrule{5pt}}

\DeclareOption{prod}{\@finaltrue\@draftfalse}
\DeclareOption{ccby}{\@ccbytrue}
\DeclareOption{links}{\@linkstrue}
\DeclareOption{print}{\@printtrue}

\def\thmhead@CPMplain#1#2#3{%
  \thmname{#1}\thmnumber{\@ifnotempty{#1}{ }\@upn{#2}}%
  \thmnote{ {\the\thm@notefont #3}}}
\DeclareOption{ams}{%
  \def\CPM@ams{\RequirePackage{amsthm,amssymb}%
               \let\thmhead\thmhead@CPMplain%
% OT 22/02/2013 incorporated fixes to \thm@notefont from cmfixes-081009.sty
               \def\th@plain{%OT
               \thm@headfont{\scshape}\thm@notefont{\normalfont}\slshape}
               \def\th@definition{%OT
               \thm@headfont{\scshape}\thm@notefont{\normalfont}\normalfont}
               \def\th@remark{%OT
               \thm@headfont{\itshape}\thm@notefont{\normalfont}\normalfont}
               \let\oldleq\leq
               \let\le\leqslant
               \let\leq\leqslant
               \let\oldgeq\geq
               \let\ge\geqslant
               \let\geq\geqslant}}
\DeclareOption{noams}{%
  \def\CPM@ams{%
               \@CPMamsfalse
               \def\proofname{Proof}
               \let\theoremstyle\@gobble
               \let\oldnewtheorem\newtheorem
               \def\newtheorem{\@ifstar\oldnewtheorem\oldnewtheorem}%
               \let\mathbb\mathbf}}
\ExecuteOptions{ams}
\InputIfFileExists{alggeom.cfg}
  {\CPM@warn{Using local configuration file.\MessageBreak
             Ignoring document options: [\@classoptionslist]}%
   \let\@classoptionslist\@empty
   \@namedef{opt@\@currname.\@currext}{}}%
  {}
\ProcessOptions
% OT 22/02/2013 added required package for definition of ps@title
\RequirePackage{ifthen}
\if@print\if@links\CPM@warn{Document option 'print' overrides option 'links'}\fi\@linksfalse\fi
\if@compatibility\LoadClass[11pt]{article}\else
\LoadClass[twoside,onecolumn,11pt]{article}\fi
\RequirePackage{latexsym}
\RequirePackage{graphicx}
\def\title{\@dblarg\CPM@title}
\def\CPM@title[#1]#2{%
  \def\@title{#2}%
  \def\@shorttitle{#1}}
\def\@title{\CPM@warn{No title}???}
\def\@shorttitle{}

\renewcommand*\author[2][]{%
  \gdef\CPM@doauthors{%
    \@authors\@andorcomma\relax\@andorcomma\relax}%
  \g@addto@macro\@curr@author{\\*#2}%
  \gdef\@curr@author@name{#2}%
  \g@addto@macro\@authors{%
    \@andorcomma,{\ignorespaces#2\unskip}}}%
\def\@authors{\@gobbletwo}
\def\CPM@doauthors{\CPM@warn{No author specified}}
\def\@curr@author{\@gobbletwo}
\def\and{\CPM@err{\protect\and\space is not supported}}
\def\@andorcomma#1#2\@andorcomma#3{%
  \ifx#3\relax
    \ifx#1\relax%
      \let\@tempa\relax
    \else
    \def\@tempa{\space\andname\space #2\@gobbletwo}%
    \fi
  \else
    \def\@tempa{#1 #2\@andorcomma#3}%
  \fi
  \@tempa}
\newcommand{\shortauthors}[1]{\gdef\CPM@shortauthor{#1}}
\let\CPM@shortauthor\@empty
\newcommand\address[2][]{%
  \ifx\@curr@author\CPM@gobble
    \CPM@err{\noexpand\address with no \string\author}\@ehd
  \else
    \expandafter\g@addto@macro\expandafter\@addresses\expandafter{%
         \expandafter\filbreak\@curr@author\CPM@address{#2}}%
    \let\@curr@author\CPM@gobble
  \fi}
\newcommand\curraddr[2][]{% OT 22/02/2013 fixed punctuation (AS)
\g@addto@macro\@addresses{\CPM@address{\textit{Current address:} #2}}}
\def\@addresses{}
\AtEndDocument{%
  \ifx\@deferlist\@empty\else\clearpage\fi
  \par
  \parindent\z@
  \parskip12\p@
  \@addresses}
\def\CPM@address#1{\\*\begingroup\def\\{, }#1\endgroup}
\def\CPM@gobble{\@gobbletwo}
\newcommand\email[2][]{%
  \ifx\@curr@author\CPM@gobble
    \CPM@err{\noexpand\email should come after corresponding \string\author}\@ehd
  \else
    \g@addto@macro\@curr@author{\quad\CPM@email{#2}}%
  \fi}
\def\CPM@email#1{\href{mailto:#1}{\textsf{#1}}}
\AtBeginDocument{%
  \providecommand\url[1]{%
    \texttt{\language\@M\hyphenchar\the\font=`\/ #1}}%
  \providecommand\href[2]{{%
    \let~\textasciitilde#2}}}

\def\thanks#1{%
  \ifx\@thanks\@empty\else\CPM@warn{Only one \string\thanks\space allowed!}\fi
    \g@addto@macro\@thanks{\footnotetext{\indent#1}}}

\newcommand{\dedication}[1]{\gdef\@dedication{#1}}
\let\@dedication\@empty
\def\keywords#1{%
  \gdef\@keywords{%
    {\itshape Keywords:\/} \ignorespaces#1\unskip}}
\let\@keywords\@empty
\newcommand\classification[2][]{%
  \gdef\@classification{%
    \href{http://www.ams.org/msc/}%
{\textit{2010 Mathematics Subject Classification}} \ignorespaces#2\unskip}}
\let\subjclass\classification
\def\@classification{\CPM@warn{No MSC classification}\textit{2010
Mathematics Subject Classification} ????}
\def\received#1{%
  \gdef\@received{Received #1}}
\def\@received{\CPM@warn{No received date}Received 0000}
\newcommand\revised[2][revised]{%
  \g@addto@macro\@revised{{, #1 #2}}}
\let\@revised\@empty
\newbox\absbox
\def\abstract{\lrbox\absbox\minipage{.9\textwidth}%
  \parindent12\p@
  \normalsize\normalfont
  \section*{\mdseries\textsc{Abstract}}}
\def\endabstract{\endminipage\endlrbox}
% OT 22/02/2013 incorporated changes from cmfixes-081009.sty into maketitle
\def\maketitle{%
\if@compatibility\CPM@err{\noexpand\maketitle does not work in
obsolete LaTeX209 documents}\thispagestyle{title}\else
  \ifx\@curr@author\CPM@gobble
  \else
    \begingroup
      \def\\*{, }%
      \def\\{ }%
      \let\thanks\@gobble%
      \let\footnote\thanks%
      \def\@curr@author{\@curr@author@name}%eval!
      \CPM@warn{No \string\address\space entry for \@curr@author}%
    \endgroup
    \address\relax
  \fi
  \begingroup
  \long\def\@makefntext##1{\parindent 1em\noindent##1}%
  \thispagestyle{title}\label{FirstPage}%
  \global\@topnum\z@
  \normalfont
  \null\vspace{-11pt}\vspace{-2\baselineskip}\vspace{25pt}%OT 22/02/2013
  \addvspace{41.4pt}%OT/AS extend titlepage in lieu of page number
  \centering%
  \def\\{\protect\@centercr}%
  \LARGE\textbf{\@title}\par
  \addvspace{20pt}%
  \Large
  \begingroup
  \def\thanks##1{\CPM@err{\string\thanks\space and
  \string\footnote\space not allowed in \string\author}}%
  \let\footnote\thanks
  \def\\{\CPM@err{Put address data in \string\address\space not
  \string\author}, \let\\\relax}%
  \CPM@doauthors\par
  \endgroup
  \ifx\@dedication\@empty\else\addvspace{0.5\baselineskip}%
  \normalsize\textit{\@dedication}\par\fi
  \addvspace{20pt}%
  \ifvoid\absbox
    \if@draft\relax\else\CPM@warn{No abstract}\fi%
  \else
    \usebox\absbox\par
  \fi
  \if@final
    \footnotetext{\@received\@revised\@online.}% OT 22/02/2013
  \else
    \footnotetext{~}%allow space in author manuscript for future insertion of dates
  \fi
  \if@draft\relax\else\footnotetext{\@classification}\fi%
    \ifx\@keywords\@empty\else\footnotetext{\@keywords}\fi%
  \if@final
    \if@ccby
      \footnotetext{This journal is \copyright\ \@journalpublisher\
      \@volumeyear. This article is distributed with Open Access under the terms of the
      \href{http://creativecommons.org/licenses/by/3.0/}{Creative Commons Attribution License}, which
      permits unrestricted reuse, distribution, and reproduction in any medium, provided that the original
      work is properly cited.}% OT 22/02/2013
    \else
      \footnotetext{This journal is \copyright\ \@journalpublisher\
      \@volumeyear. This article is distributed with Open Access under the terms of the
      \href{http://creativecommons.org/licenses/by-nc/3.0/}{Creative Commons Attribution Non-Commercial License},
      which permits non-commercial reuse, distribution, and reproduction in any medium, provided that the original
      work is properly cited. For commercial re-use, please contact the \@journalpublisher.}% OT 22/02/2013
    \fi
  \else % OT reserve space for copyright line (to be above \thanks argument) when prod option is used)
    \g@addto@macro\@thanks{\footnotetext{~\\~\\~\\~}}
  \fi
  \@thanks
  \endgroup
\fi %end of \if@compatibility
  \let\and\relax
  \let\author\relax
  \let\keywords\relax
  \let\@keywords\relax
  \let\address\relax
  \let\email\relax
  \let\@address\relax
  \let\maketitle\relax
  \let\thanks\@gobble
  \def\abstract{%
    \CPM@err{abstract must be before \protect\maketitle}%\@ehd
    \lrbox\absbox\minipage{.9\textwidth}}
    \enlargethispage{41.4pt}% extend titlepage in lieu of page number
}
% OT 22/02/2013 incorporated parts of cmfixes-081009.sty
\def\ps@cpm{%
  \def\@oddhead{%
      \scshape
      \def\\{\unskip\space\ignorespaces}%
      \hss\@shorttitle\hss}%
  \def\@evenhead{%
     \def\\{\unskip\space\ignorespaces}%
     \scshape\hss\ifx\CPM@shortauthor\@empty\CPM@doauthors%
      \else\CPM@shortauthor\fi\hss}%
  \def\@oddfoot{\parbox[t]{\textwidth}{{$\phantom{0}$}\hfill%
  \ifthenelse{\value{ip} = 1}{\thepage}%
  {Page\ \thepage\ of\ \@endpage}%
  \hfill{$\phantom{0}$}\par}}%
  \let\@evenfoot\@oddfoot}
% OT 22/02/2013 incorporated parts of cmfixes-081009.sty
\def\ps@cpmlast{%
  \def\@oddhead{%
      \scshape
      \def\\{\unskip\space\ignorespaces}%
      \hss\@shorttitle\hss}%
  \let\@evenhead\@oddhead
  \def\@oddfoot{\parbox[t]{\textwidth}{{$\phantom{0}$}\hfill%
  \ifthenelse{\value{ip} = 1}{\thepage}%
  {Page\ \thepage\ of\ \@endpage}%
  \hfill{$\phantom{0}$}\par}}%
  \let\@evenfoot\@oddfoot}
% OT 22/02/2013 incorporated parts of cmfixes-081009.sty
  \def\ps@title{%
  \if@final\def\@oddhead{%
  \if@print%
    \includegraphics[width=1.25cm]{aglogo-bw.eps}%
  \else
    \includegraphics[width=1.25cm]{aglogo.eps}%
  \fi
  \begin{tabular}[b]{l}%
  \journalname\
  \ifthenelse{\value{ip} = 1}{\@volumenumber\ (\@volumeyear) \@startpage--\@endpage}%
  {(Page\ \@startpage\ of\ \@endpage)}\\*[1pt]
   doi:\@DOI\\*[-6.2pt]~
  \end{tabular}\hss}%
  \else\def\@oddhead{}\fi%
  \let\@evenhead\@oddhead
  \def\@oddfoot{}
  \let\@evenfoot\@oddfoot}
\def\ps@headings{\CPM@warn{headings pagestyle ignored}}
\ps@cpm

\def\@volumeyear{\CPM@warn{No volume year}0000}
\def\@volumenumber{\CPM@warn{No volume number}0}
\def\@DOI{\CPM@warn{No DOI}0000000000000000000}

\def\@startpage{\pageref{FirstPage}}
\def\@endpage{\pageref{LastPage}}

\def\volumeyear#1{\gdef\@volumeyear{#1}}
\def\volumenumber#1{\gdef\@volumenumber{#1}}
\def\DOI#1{\gdef\@DOI{#1}}
\def\startpage#1{\gdef\@startpage{#1}\c@page#1}
\def\endpage#1{\gdef\@endpage{#1}}

\def\lastpage@putlabel{%
  \if@filesw
    \advance\c@page\m@ne
     \immediate\write\@auxout{\string
     \newlabel{LastPage}{{}{\thepage}{}{}{}}}%
     \advance\c@page\@ne
  \fi}
\AtEndDocument{% OT fixed 22/02/2013
\clearpage\thispagestyle{cpmlast}\lastpage@putlabel}%
\renewcommand\normalsize{%
   \@setfontsize\normalsize\@xipt{13.6}%
   \abovedisplayskip 6\p@ \@plus\p@ \@minus\p@
   \belowdisplayskip \abovedisplayskip
   \abovedisplayshortskip 3\p@ \@plus\p@
   \belowdisplayshortskip  \abovedisplayshortskip
   \let\@listi\@listI}
\normalsize
\renewcommand\small{%
   \@setfontsize\small\@xpt\@xiipt
   \abovedisplayskip 5\p@ \@plus\p@ \@minus\p@
   \belowdisplayskip \abovedisplayskip
   \abovedisplayshortskip \z@ \@plus3\p@
   \belowdisplayshortskip \abovedisplayshortskip
   \def\@listi{\leftmargin\leftmargini
               \topsep 3\p@ \@plus\p@ \@minus\p@
               \parsep \z@skip
               \itemsep \topsep}%
}
\renewcommand\footnotesize{%
   \@setfontsize\footnotesize\@ixpt{10}%
   \abovedisplayskip 8\p@ \@plus2\p@ \@minus4\p@
   \abovedisplayshortskip \z@ \@plus\p@
   \belowdisplayshortskip 4\p@ \@plus2\p@ \@minus2\p@
   \def\@listi{\leftmargin\leftmargini
               \topsep 4\p@ \@plus2\p@ \@minus2\p@
               \parsep 2\p@ \@plus\p@ \@minus\p@
               \itemsep \parsep}%
   \belowdisplayskip \abovedisplayskip
}

\partopsep\z@ \@plus \p@
\def\@listi{\leftmargin\leftmargini
            \parsep\z@skip
            \topsep 3\p@ \@plus\p@
            \itemsep3\p@ \@plus\p@ \@minus\p@}
\let\@listI\@listi
\@listi
\def\@listii {\leftmargin\leftmarginii
              \labelwidth\leftmarginii
              \advance\labelwidth-\labelsep
              \topsep    3\p@ \@plus\p@ \@minus\p@
              \parsep\z@skip
              \itemsep   \parsep}
\setlength\leftmargini  {2pc}
\leftmargin  \leftmargini
\setlength\leftmarginii  {1.5pc}
\setlength\leftmarginiii {1.5pc}
\setlength\leftmarginiv  {1.5pc}
\setlength  \labelsep  {6pt}
\setlength  \labelwidth{\leftmargini}
\addtolength\labelwidth{-\labelsep}
\@beginparpenalty -\@lowpenalty
\@endparpenalty   -\@lowpenalty
\@itempenalty     -\@lowpenalty
\renewcommand\theenumi{\@roman\c@enumi}
\renewcommand\theenumii{(\@alph\c@enumii)}
\renewcommand\theenumiii{(\@roman\c@enumiii)}
\renewcommand\theenumiv{\@Alph\c@enumiv}
% 22/02/2013 OT incorporated 2 fixes from cmfixes-081009.sty
\renewcommand\labelenumi{(\@roman\c@enumi)}%OT
\renewcommand\labelenumii{\theenumii}
\renewcommand\labelenumiii{(\@roman\c@enumiii)}%OT
\renewcommand\labelenumiv{\theenumiv.}
\renewcommand\p@enumii{\theenumi}
\renewcommand\p@enumiii{\theenumi\theenumii}
\renewcommand\p@enumiv{\p@enumiii\theenumiii}
\renewcommand\labelitemi{\normalfont\bfseries \textendash}
\renewcommand\labelitemii{\textasteriskcentered}
\renewcommand\labelitemiii{\textperiodcentered}
\renewcommand\labelitemiv{\textperiodcentered}
\def\enumerate{%
  \ifnum \@enumdepth >\thr@@\@toodeep\else
    \advance\@enumdepth\@ne
    \edef\@enumctr{enum\romannumeral\the\@enumdepth}%
      \expandafter
      \list
        \csname label\@enumctr\endcsname
        {\usecounter\@enumctr\def\makelabel##1{\hss\llap{\upshape##1}}}%
  \fi}
\let\endenumerate =\endlist

\renewenvironment{description}
               {\list{}{\labelwidth\z@ \itemindent-\leftmargin
                        \listparindent\parindent
                        \let\makelabel\descriptionlabel}}
               {\endlist}
\renewcommand*\descriptionlabel[1]{\hspace{\listparindent}%
                                \hspace{\labelsep}
                                \normalfont\bfseries #1}
\setlength\parindent{1.5em}
\setlength\listparindent\parindent
\setlength\topsep{8pt \@plus 2pt \@minus 4pt}
\setlength\partopsep{0pt \@plus 1pt}
\setlength\itemsep{0pt \@plus 2pt}
\setlength\parskip{2\p@ \@plus \p@}
\def\section{%
  \def\@sectpunct{.}
  \@startsection
    {section}{1}{\z@}{-18\p@ \@plus 2\p@ \@minus 2\p@}%
    {6\p@}{\centering\normalfont\normalsize\bfseries}}
\def\@seccntformat#1{\textup{\csname the#1\endcsname}\@sectpunct%
   \hspace{1ex}}
\def\subsection{%
  \def\@sectpunct{}
  \@startsection
    {subsection}{2}{\z@}{-12\p@ \@plus 1.2\p@ \@minus 1.2\p@}%
    {1sp}{\normalfont\normalsize\bfseries}}
\def\subsubsection{%
  \def\@sectpunct{}
  \@startsection
    {subsubsection}{3}{\parindent}{12\p@ \@plus -1.2\p@ \@minus-1.2\p@}%
    {-1em}{\normalfont\normalsize\itshape}}
\def\paragraph{%
  \def\@sectpunct{}
  \@startsection
    {paragraph}{4}{\z@}{12\p@}%
    {-1em}{\normalfont\normalsize\itshape}}
\def\subparagraph{%
  \def\@sectpunct{}
  \@startsection
    {paragraph}{5}{\z@}{12\p@}%
    {-1em}{\normalfont\normalsize\itshape}}
\newcounter {Lsection} % never used!
\renewcommand \theLsection {\@arabic\c@Lsection} % also never used
\def\Lsection{%
  \@startsection{Lsection}{1}{\z@}{-18\p@ \@plus 2\p@ \@minus 2\p@}%
    {6\p@}{\normalfont\normalsize\scshape}}
\setcounter{secnumdepth}{3}
\setcounter{tocdepth}{2}


\newenvironment{acknowledgements}
                {\Lsection*{\acknowledgename}}
                {}

\newenvironment{addinproof}
                {\subsubsection*{\addinprooftext}}
                {}
\renewcommand\appendix{\par
  \setcounter{section}{0}%
  \setcounter{subsection}{0}%
  \renewcommand\thesection{\@Alph\c@section}%
  \renewcommand\section{%
   \if@noskipsec \leavevmode \fi
   \par
   \addvspace{18\p@ \@plus 2\p@ \@minus 2\p@}%
   \@afterindentfalse\secdef\Appendix\sAppendix}}
\newcommand{\Appendix}[2][?]{%
\refstepcounter{section}%
\addcontentsline{toc}{section}%
{\appendixname~\thesection. #1}%
\par
{\centering\normalfont\normalsize\bfseries\appendixname~\thesection.
#1\par}\vskip6pt\@afterheading}

\newcommand{\sAppendix}[1]{%
\addcontentsline{toc}{section}%
{\appendixname. #1}%
\par
{\centering\normalfont\normalsize\bfseries\appendixname. #1\par}%
\vskip6pt\@afterheading}

% OT 22/02/2013 included, from cmfixes-081009.sty, using 'quote' environment
\renewcommand\tableofcontents{\toctest%
\begin{quote}
\parskip0pt\section*{\contentsname}%
    \@starttoc{toc}
\end{quote}}

\renewcommand*\l@section[2]{%
  \ifnum \c@tocdepth >\z@
    \addpenalty\@secpenalty
    %\addvspace{1.0em \@plus\p@}% don't want this!
    \setlength\@tempdima{1.5em}%
    \begingroup
      \parindent \z@ \rightskip \@pnumwidth
      \parfillskip -\@pnumwidth
      \leavevmode \bfseries
      \advance\leftskip\@tempdima
      \hskip -\leftskip
      #1\nobreak\hfil \nobreak\hb@xt@\@pnumwidth{\hss #2}\par
    \endgroup
  \fi}
% OT 22/02/2013 from cmfixes-081009.sty, add 'References' to ToC
\setlength\bibindent{0em}
\renewenvironment{thebibliography}[1]
     {\addcontentsline{toc}{section}{\refname}% OT
     \Lsection*{\refname}%
      \small\list{\@biblabel{\@arabic\c@enumiv}}%
           {\settowidth\labelwidth{\@biblabel{#1}}%
            \leftmargin\labelwidth
            \setlength\labelsep{4pt}
            \advance\leftmargin\labelsep
            \usecounter{enumiv}%
            \let\p@enumiv\@empty
            \renewcommand\theenumiv{\@arabic\c@enumiv}}%
      \sloppy
      \clubpenalty4000
      \@clubpenalty \clubpenalty
      \widowpenalty4000%
      \sfcode`\.\@m}
     {\def\@noitemerr
       {\@latex@warning{Empty `thebibliography' environment}}%
      \endlist}
\def\footnoterule{\kern-6\p@
    \hrule\kern 5.6\p@} % the \hrule is .4pt high

\renewcommand\@makefntext[1]{%
    \parindent12pt%
    \noindent
    \@makefnmark#1}
\setlength\footnotesep{8pt}
\setlength{\skip\footins}{12\p@ \@plus 12\p@ \@minus 1\p@}
\skip\@mpfootins = \skip\footins
\pagestyle{cpm}
\pagenumbering{arabic}
\@twosidetrue
\onecolumn
\frenchspacing
\def\eqnarray{%
   \stepcounter{equation}%
   \def\@currentlabel{\p@equation\theequation}%
   \global\@eqnswtrue
   \m@th
   \global\@eqcnt\z@
   \tabskip\@centering
   \let\\\@eqncr
   $$\everycr{}\halign to\displaywidth\bgroup
      \tabskip\z@skip$\hfil\displaystyle{##}$%
      &\global\@eqcnt\@ne\hfil${\displaystyle{}##{}}$\hfil
      &\global\@eqcnt\tw@
         $\displaystyle{##}$\hfil
      \tabskip\@centering
      &\global\@eqcnt\thr@@\llap{##}%
      \tabskip\z@skip
      \cr}
\def\@uclcnotmath#1#2#3#4{\begingroup
      #1%
      \def\({$}\let\)\(% $
      \def\reserved@a##1##2{\let#2\reserved@a}%
      \expandafter\reserved@a\@uclclist\reserved@b{\reserved@b\@gobble}%
      \protected@edef\reserved@a{\endgroup
          \noexpand\@skipmath#3#4$\valign$}%
      \reserved@a}
\def\@skipmath#1{%
\def\@skipmath##1##2$##3${%
  \@skipensuremath##1##2#1\valign
  \ifx\valign##3%
  \else
    $##3$%
    \expandafter\@skipmath\expandafter##1%
  \fi}%
\def\@skipensuremath##1##2#1##3{%
  ##1{##2}%
  \ifx\valign##3%
  \else
    $##3$%
    \expandafter\@skipensuremath\expandafter##1%
  \fi}}
\expandafter\@skipmath\csname ensuremath \endcsname
\DeclareRobustCommand\MakeTextUppercase{%
  \@uclcnotmath{\def\i{I}\def\j{J}}{##1##2}\uppercase}
\DeclareRobustCommand\MakeTextLowercase{%
  \@uclcnotmath{}{##2##1}\lowercase}
\setlength\abovecaptionskip{10\p@}
\setlength\belowcaptionskip{10\p@}
% OT 22/02/2013 included following from cmfixes-081009.sty
% To correct punctuation in figure captions
\long\def\@makecaption#1#2{%
  \ifnum\@tempcnta<64\vspace\abovecaptionskip\fi
  \sbox\@tempboxa{\textsc{#1}. #2}%
  \ifdim \wd\@tempboxa >\hsize
    \textsc{#1}. #2\par
  \else
    \global \@minipagefalse
    \hbox to\hsize{\hfil\box\@tempboxa\hfil}%
  \fi
  \ifnum\@tempcnta<64\else\vskip\belowcaptionskip\fi}
\setlength\voffset{-1in}
\setlength\hoffset{-1in}
\setlength\headsep{12pt}
\setlength\topskip\baselineskip
\setlength\marginparsep{5pt}
\setlength\marginparwidth{18pt}
\setlength\marginparpush{5pt}
\setlength\headheight{3\baselineskip}
\setlength\topmargin{21.8pt}
\setlength{\footskip}{41.4\p@}% OT 22/02/2013 changed from 21pt
\setlength\textheight{47\baselineskip}% OT 22/02/2013 changed from 49
% OT ensure titlepage main text stays same if shorter copyright statement used
\if@ccby
  \addtolength{\footskip}{10\p@}
  \addtolength{\textheight}{-10\p@}
\fi
% OT 22/02/2013 incorporated parts of cmfixes-081009.sty
\setlength\paperwidth{210mm} %OT
\setlength\paperheight{280mm} %OT
\setlength\columnsep{2pc}
\setlength\oddsidemargin{26.5mm} % OT
\setlength\evensidemargin{22.6mm} % OT 22/02/2013 changed from 2.5cm
\setlength\textwidth{160.9mm}% OT 22/02/2013 changed from 49
%Needed to set PDF page size
\special{papersize=210mm,280mm}
\CPM@ams
\if@CPMams\else\newcommand{\openbox}{\leavevmode
  \hbox to.77778em{%
  \hfil\vrule
  \vbox to.675em{\hrule width.6em\vfil\hrule}%
  \vrule\hfil}}
\providecommand{\qedsymbol}{\openbox}
\DeclareRobustCommand{\qed}{%
  \ifmmode % if math mode, assume display: omit penalty etc.
  \else \leavevmode\unskip\penalty9999 \hbox{}\nobreak\hfill
  \fi
  \quad\hbox{\qedsymbol}}
\newenvironment{proof}[1][\proofname]{\par
  \normalfont \topsep6\p@\@plus6\p@\relax
  \trivlist
  \item[\hskip\labelsep
        \itshape
    #1.]\ignorespaces
}{%
  \qed\endtrivlist\@endpefalse
}
\fi
\if@proofqedboxes\else\let\qed\relax\fi


\def\@cite#1#2{[{{\citeform{#1}}\if@tempswa , #2\fi}]}
\let\citeform\relax
\def\@biblabel#1{#1~}
\providecommand{\bysame}{\leavevmode\hbox to3em{\hrulefill}\thinspace}
\providecommand{\textsuperscript}[1]{%
  \ensuremath{{}^{\mbox{\normalfont\scriptsize#1}}}}
\providecommand{\@textsuperscript}[1]{%
  \ensuremath{{}^{\mbox{\normalfont\scriptsize#1}}}}
\providecommand\MakeUppercase[1]{%
  \protected@edef\@tempa{\uppercase{#1}}\@tempa}
\def\hb@xt@{\hbox to}
\def\contentsname{Contents}
\def\listfigurename{List of Figures}
\def\listtablename{List of Tables}
\def\refname{References}
\def\indexname{Index}
\def\figurename{Figure}
\def\tablename{Table}
\def\partname{Part}
\def\appendixname{Appendix}
\def\abstractname{Abstract}
\def\today{\ifcase\month\or
  January\or February\or March\or April\or May\or June\or
  July\or August\or September\or October\or November\or December\fi
  \space\number\day, \number\year}

\def\journalBaseURL{http://algebraicgeometry.nl}
\def\journalname{\href{\journalBaseURL}{Algebraic Geometry}}
\def\@journalissn{2214--2584}
\def\@journalpublisher{\href{\journalBaseURL}%
  {Foundation Compositio Mathematica}}
\def\andname{and}
\def\ppname{pp}
\def\numbername{number}
\def\volumename{volume}
\def\acknowledgename{Acknowledgements}

\def\addinprooftext{Added in proof}
%% \CheckSum{1644}
%% \CharacterTable
%%  {Upper-case    \A\B\C\D\E\F\G\H\I\J\K\L\M\N\O\P\Q\R\S\T\U\V\W\X\Y\Z
%%   Lower-case    \a\b\c\d\e\f\g\h\i\j\k\l\m\n\o\p\q\r\s\t\u\v\w\x\y\z
%%   Digits        \0\1\2\3\4\5\6\7\8\9
%%   Exclamation   \!     Double quote  \"     Hash (number) \#
%%   Dollar        \$     Percent       \%     Ampersand     \&
%%   Acute accent  \'     Left paren    \(     Right paren   \)
%%   Asterisk      \*     Plus          \+     Comma         \,
%%   Minus         \-     Point         \.     Solidus       \/
%%   Colon         \:     Semicolon     \;     Less than     \<
%%   Equals        \=     Greater than  \>     Question mark \?
%%   Commercial at \@     Left bracket  \[     Backslash     \\
%%   Right bracket \]     Circumflex    \^     Underscore    \_
%%   Grave accent  \`     Left brace    \{     Vertical bar  \|
%%   Right brace   \}     Tilde         \~}
%%
% OT 22/02/2013 included from cmfixes-081009.sty
% offprint macro from Ola
\def\offprintpage{%
\setlength\topmargin{80mm}
\setlength\oddsidemargin{22.1mm}
\setlength\evensidemargin{22mm}
% Remove titlepage header
\def\ps@title{%
  \def\@oddhead{}
  \let\@evenhead\@oddhead
  \def\@oddfoot{}
  \let\@evenfoot\@oddfoot}
\newbox\dummybox
\def\abstract{\lrbox\dummybox}
\def\endabstract{\endlrbox}
\let\savemaketitle\maketitle
\def\footnotetext##1{}
\def\maketitle{%
\let\@dedication\@empty%
\let\@addresses\@empty
\savemaketitle\clearpage\enddocument}}
% OT 22/02/2013 included from cmfixes-081009.sty
% Style changes for Parts AS 12/11/03
\renewcommand\part{%
   \if@noskipsec \leavevmode \fi
   \par
   \addvspace{6.7ex}%
   \@afterindentfalse
   \secdef\@part\@spart}

\def\@part[#1]#2{%
    \ifnum \c@secnumdepth >\m@ne
      \refstepcounter{part}%
      \addcontentsline{toc}{part}{Part~\thepart.\ #1}%
    \else
      \addcontentsline{toc}{part}{#1}%
    \fi
    {\parindent \z@ \raggedright
     \interlinepenalty \@M
     \normalfont
     \ifnum \c@secnumdepth >\m@ne
       \centering\Large\bfseries \partname~\thepart.%
       \hspace{1ex}%
     \fi%
     \Large\bfseries #2%
     \markboth{}{}\par}%
    \nobreak
    \vskip 4.7ex
    \@afterheading}
\def\@spart#1{%
    {\parindent \z@ \raggedright
     \interlinepenalty \@M
     \normalfont
     \centering\Large\bfseries #1\par}%
     \nobreak
     \vskip 4.7ex
     \@afterheading}
\renewcommand*\l@part[2]{%
  \ifnum \c@tocdepth >-2\relax
    \addpenalty\@secpenalty
    \addvspace{0.75em \@plus\p@}%
    \begingroup
      \parindent \z@ \rightskip \@pnumwidth
      \parfillskip -\@pnumwidth
      {\leavevmode
       \normalsize \bfseries #1\hfil \hb@xt@\@pnumwidth{\hss #2}}\par
       \nobreak
       \if@compatibility
         \global\@nobreaktrue
         \everypar{\global\@nobreakfalse\everypar{}}%
      \fi
    \endgroup
  \fi}
% OT 22/02/2013 included from cmfixes-081009.sty
% To force more space above graphics
\renewenvironment{figure}{%
\@ifnextchar[%
{\@float{figure}}
{\@float{figure}\vspace*{7pt}}}
{\end@float}
% OT 22/02/2013 included from cmfixes-081009.sty
% 3/3/04 To allow single page documents
\newif\ifsinglepage
\DeclareOption{singlepage}{\singlepagetrue}  % single page option
\ProcessOptions\relax
\ifsinglepage
%Tidy page range
%31/7/07 incremental publishing
\def\ps@title{%
  \if@final\def\@oddhead{%
\includegraphics[width=1.25cm]{aglogo.eps}%
  \begin{tabular}[b]{l}%
  \journalname\
  \ifthenelse{\value{ip} = 1}{\@volumenumber\ (\@volumeyear) \@startpage}%
  {(Page\ \@startpage\ of\ \@startpage)}\\*[1pt]
   doi:\@DOI\\*[-6.2pt]~
  \end{tabular}\hss}%
  \else\def\@oddhead{}\fi%
  \let\@evenhead\@oddhead
  \def\@oddfoot{}
  \let\@evenfoot\@oddfoot}
% make lastpage header same as titlepage
\let\ps@cpmlast\ps@title
\fi
% OT 22/02/2013 incorporated from cmfixes-081009.sty
% Online date funcionality added
\newcommand\online[2][published online]{%
  \g@addto@macro\@online{{, #1 #2}}}
\let\@online\@empty
% OT section symbol macro 20/12/2005
\let\S@old\S
\let\oldsectionsymbol\S % keep accessible in case the new macro flunks
\def\S{\@ifnextchar \S{\@twoS}{\@oneSa}}
\def\@twoS#1{\S@old\@oneSa}
\def\@oneSa{\@ifnextchar \,{\@oneSspace}{\@oneSb}}
\def\@oneSb{\@ifnextchar \!{\@oneSspace}{\@oneSc}}
\def\@oneSc{\@ifnextchar \:{\@oneSspace}{\@oneSd}}
\def\@oneSd{\@ifnextchar \;{\@oneSspace}{\@oneSe}}
\def\@oneSe{\@ifnextchar ~{\@oneSspace}{\@oneSf}}
\def\@oneSf{\@ifnextchar \ {\@oneSspace}{\@oneSg}}
\def\@oneSg{\@ifnextchar \space{\@oneSspace}{\@oneSother}}
\def\@oneSspace#1{\S@old\nobreak\,\nobreak\ignorespaces}
\def\@oneSother{\S@old\nobreak\,\nobreak\ignorespaces}
%20/12/05 enumerate environment where labelwidth is set
\newenvironment{wideenumerate}[1]
{\begin{list}{}%
{\renewcommand\makelabel[1]{\hss\llap{\upshape##1}}
\settowidth\labelwidth{#1}%
\leftmargin\labelwidth
                \advance\leftmargin\labelsep}}%
{\end{list}}

%31/7/07 first view, unpaginated, page numbering
%NB also see \ps@title, \ps@cpm and \ps@cpmlast above
\newcounter{ip}
\setcounter{ip}{1}
\newif\if@ip
\DeclareOption{ip}{\@iptrue}
\ProcessOptions\relax
\if@ip
\addtocounter{ip}{1}
\fi
%29/10/07
\newcommand{\emaildot}{\raisebox{-2.25pt}{${\cdot}$}}
%3/10/08
\newcounter{toctest}
\def\endpage#1{\gdef\@endpage{#1}\setcounter{toctest}{#1}}
\newcommand\toctest{\ifthenelse{\value{toctest} > 999}{%
\renewcommand\@pnumwidth{2.4em}%
\renewcommand\@tocrmarg{3.4em}}
{}}
% OT 22 February 2013 - Algebraic Geometry color links
\if@links
\RequirePackage{color}\definecolor{AGred}{RGB}{200,3,3}%
\RequirePackage{hyperref}%
\hypersetup{colorlinks=true, linkcolor=AGred, anchorcolor=AGred,
citecolor=AGred, filecolor=AGred, menucolor=AGred,
urlcolor=AGred, pdfcreator={Algebraic Geometry}}
\fi
\endinput
%%
%% End of file `alggeom.cls'.
