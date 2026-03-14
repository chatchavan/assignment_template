%% writtenassignmentchat.cls  –  Custom LaTeX document class
%%
%% Body text : Helvetica Neue equivalent (helvet), 11 pt
%% Section   : 12 pt, bold
%% Subsection: 11 pt, italic, underlined
%% Spacing   : 1.3 lines
%% Margins   : 1 cm top/bottom, 2 cm left/right
%% Title     : compact, no extra top space; optional
%% Word count: printed before references (set \wordcountvalue in preamble)
%% Line nos  : continuous, grey 50%, left margin, suppressed in references
%% Bib style : apalike with clickable DOIs

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{writtenassignmentchat}[2024/01/01 Written Assignment Class]

%% ── Base ────────────────────────────────────────────────────────────────────
\LoadClass[11pt,a4paper]{article}

%% ── Fonts ───────────────────────────────────────────────────────────────────
\RequirePackage{fix-cm}
\RequirePackage[T1]{fontenc}
\RequirePackage{helvet}
\renewcommand{\familydefault}{\sfdefault}

% Disable ligatures
\usepackage{microtype}
\DisableLigatures{encoding = *, family = *}

%% ── Line spacing ────────────────────────────────────────────────────────────
\RequirePackage{setspace}
\setstretch{1.3}

%% ── Figures & tables ────────────────────────────────────────────────────────
\RequirePackage{graphicx}
\RequirePackage{booktabs}
\graphicspath{{figures/}}

%% ── Page geometry ───────────────────────────────────────────────────────────
\RequirePackage{geometry}
\geometry{top=1cm, bottom=1.5cm, left=2cm, right=2cm, nohead, includefoot}

%% ── Colours ─────────────────────────────────────────────────────────────────
\RequirePackage{xcolor}

%% ── Page footer: "Page X of Y", bottom-right ────────────────────────────────
%% Load fancyhdr and lastpage early so \fancypagestyle is available everywhere.
\RequirePackage{fancyhdr}
\RequirePackage{lastpage}

\fancypagestyle{myfooter}{%
  \fancyhf{}%
  \fancyfoot[R]{%
    \fontsize{8pt}{10pt}\selectfont\color{black!50}%
    Page~\thepage~of~{\color{black!50}\pageref{LastPage}}%
  }%
  \renewcommand{\headrulewidth}{0pt}%
  \renewcommand{\footrulewidth}{0pt}%
}
\pagestyle{myfooter}

%% ── Hyperlinks – no coloured boxes, no red/green borders ────────────────────
\RequirePackage[colorlinks=true,
                linkcolor=black,
                citecolor=black,
                urlcolor=blue,
                filecolor=black,
                pdfborder={0 0 0}]{hyperref}

%% ── autoref label names ─────────────────────────────────────────────────────
\def\figureautorefname{Figure}
\def\tableautorefname{Table}
\def\sectionautorefname{Section}
\def\subsectionautorefname{Section}
\def\subsubsectionautorefname{Section}
\def\equationautorefname{Equation}

%% ── Smart quotes ─────────────────────────────────────────────────────────────
%% \enquote{text} gives locale-aware open/close quotes.
%% MakeOuterQuote converts straight "..." in source to typographic quotes.
\RequirePackage{csquotes}
\MakeOuterQuote{"}

%% ── Compact lists – same line spacing as body text ──────────────────────────
%% itemsep=0pt means no *extra* space; the natural 1.3× baselineskip remains.
\RequirePackage{enumitem}
\setlist[itemize]{itemsep=0pt, topsep=0pt, parsep=0pt, partopsep=0pt}
\setlist[enumerate]{itemsep=0pt, topsep=0pt, parsep=0pt, partopsep=0pt}

%% ── Section headings ────────────────────────────────────────────────────────
\RequirePackage{titlesec}

\titleformat{\section}
  {\fontsize{12pt}{14.4pt}\selectfont\bfseries\sffamily}
  {\thesection}{1em}{}
\titlespacing*{\section}{0pt}{6pt plus 2pt}{3pt plus 1pt}

\titleformat{\subsection}
  {\fontsize{11pt}{13.2pt}\selectfont\sffamily\itshape}
  {\thesubsection}{1em}{}
\titlespacing*{\subsection}{0pt}{4pt plus 1pt}{2pt plus 1pt}

\let\mf@orig@ssec\subsection
\newcommand{\mf@ulsubsec}[2][\relax]{%
  \if\relax#1\relax
    \mf@orig@ssec{\texorpdfstring{\underline{#2}}{#2}}%
  \else
    \mf@orig@ssec[#1]{\texorpdfstring{\underline{#2}}{#2}}%
  \fi
}
\renewcommand{\subsection}{\mf@ulsubsec}

%% ── Compact title ────────────────────────────────────────────────────────────
%% \maketitle is redefined to:
%%   - show title flush at top with no extra space
%%   - show line numbers on the first page (thispagestyle = myfooter, not empty)
\renewcommand{\maketitle}{%
  \begingroup
    \setlength{\parindent}{0pt}%
    \setlength{\parskip}{0pt}%
    \vspace*{0pt}%
    \ifx\@title\@empty\else
      {\fontsize{13pt}{15.6pt}\selectfont\bfseries\sffamily\@title\par}%
    \fi
  \endgroup
  \thispagestyle{myfooter}%   % first page gets footer (and line numbers)
}

%% ── Line numbers (continuous, grey 50%, left margin) ────────────────────────
\RequirePackage{lineno}
\renewcommand{\linenumberfont}{\normalfont\tiny\color{black!50}}
\setlength{\linenumbersep}{7pt}
\leftlinenumbers

%% Switch: \showlinenumberstrue (default) or \showlinenumbersfalse in preamble
\newif\ifshowlinenumbers
\showlinenumberstrue

\AtBeginDocument{%
  \ifshowlinenumbers\linenumbers\else\nolinenumbers\fi
}

%% ── URL footnote helper ──────────────────────────────────────────────────────
\newcommand{\linkedfootnote}[2]{%
  \href{#1}{#2}\footnote{\url{#1}}%
}

%% ── Bibliography with clickable DOIs ────────────────────────────────────────
\RequirePackage{natbib}
\bibliographystyle{apalike-doi}

%% 8 pt, single spacing, no gap between entries
\renewcommand{\bibfont}{\fontsize{8pt}{9.6pt}\selectfont}
\setlength{\bibsep}{0pt}

%% \doi{10.xxxx/yyyy} renders as a clickable "doi:..." link.
%% apalike.bst calls \doi{...} when a doi field is present in the .bib entry.
\newcommand{\doi}[1]{\href{https://doi.org/#1}{\texttt{doi:#1}}}

%% ── Word count ───────────────────────────────────────────────────────────────
\newcommand{\wordcountvalue}{%
  (set \texttt{\textbackslash wordcountvalue} in preamble)}

\newcommand{\printwordcount}{%
  \nolinenumbers
  \par\vspace{4pt}%
  {\hfill
   \fontsize{9pt}{11pt}\selectfont\color{black!55}%
   \textit{Compiled on~\today. Word count (excluding references):~\wordcountvalue}}%
  \par\vspace{2pt}%
}

%% ── Main bibliography macro ──────────────────────────────────────────────────
\newcommand{\insertbibliography}[1]{%
  \printwordcount
  \nolinenumbers
  \begin{singlespace}%
  \bibliography{#1}%
  \end{singlespace}%
}

\endinput
