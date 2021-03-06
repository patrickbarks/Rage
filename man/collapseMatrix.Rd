% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/collapseMatrix.R
\name{collapseMatrix}
\alias{collapseMatrix}
\title{Collapse a matrix population model to a smaller number of stages}
\usage{
collapseMatrix(matU, matF, matC = NULL, collapse)
}
\arguments{
\item{matU}{The survival component of a matrix population model (i.e. a
square projection matrix reflecting survival-related transitions; e.g.
progression, stasis, and retrogression)}

\item{matF}{The sexual component of a matrix population model (i.e. a square
projection matrix reflecting transitions due to sexual reproduction)}

\item{matC}{The clonal component of a matrix population model (i.e. a square
projection matrix reflecting transitions due to clonal reproduction).
Defaults to \code{NULL}, indicating no clonal reproduction (i.e.
\code{matC} is a matrix of zeros).}

\item{collapse}{A list giving the mapping between stages of the original
matrix and the desired stages of the collapsed matrix (e.g. \code{list(1,
2:3, 4)}). The indices of \code{collapse} correspond to the desired stages
of the collapsed matrix, and the corresponding values give the stage index
or vector of stage indices from the original matrix that correspond to the
relevant stage of the collapsed matrix.

See \emph{Missing Stages} for handling of \code{NA} within \code{collapse}.}
}
\value{
A list with four elements:
  \item{matA}{Collapsed projection matrix}
  \item{matU}{Survival component of the collapsed projection matrix}
  \item{matF}{Sexual reproduction component of the collapsed projection
  matrix}
  \item{matC}{Clonal reproduction component of the collapsed projection
  matrix}
}
\description{
Collapse a matrix population model to a smaller number of stages. For
instance, to compare properties of multiple projection matrices with
different numbers of stages, one might first collapse those matrices to a
standardized set of stages (e.g. propagule, pre-reproductive, reproductive,
and post-reproductive). The transition rates in the collapsed matrix are a
weighted average of the transition rates from the relevant stages of the
original matrix, weighted by the relative proportion of each stage class
expected at the stable distribution.
}
\note{
This method of collapsing a matrix population model preserves the
  equilibrium population growth rate (\eqn{lamda}) and relative stable
  distribution, but is not expected to preserve other traits such as relative
  reproductive values, sensitivities, net reproductive rates, life
  expectancy, etc.
}
\section{Missing Stages}{

The collapsed matrix will always be of dimension \code{length(collapse)},
even if one or more elements of the \code{collapse} argument is \code{NA}
(corresponding to a desired stage of the collapsed matrix that is not present
in the original matrix). In the collapsed matrix, any row/column
corresponding to a missing stage will be coerced to \code{NA}.
}

\examples{
matU <- rbind(c(  0,   0,   0,   0),
              c(0.5,   0,   0,   0),
              c(  0, 0.3,   0,   0),
              c(  0,   0, 0.2, 0.1))

matF <- rbind(c(  0,   0, 1.1, 1.6),
              c(  0,   0, 0.8, 0.4),
              c(  0,   0,   0,   0),
              c(  0,   0,   0,   0))
              
matC <- rbind(c(  0,   0, 0.4, 0.5),
              c(  0,   0, 0.3, 0.1),
              c(  0,   0,   0,   0),
              c(  0,   0,   0,   0))

# collapse reproductive stages
collapse1 <- list(1, 2, 3:4)
collapseMatrix(matU, matF, matC, collapse1)

# collapse pre-reproductive stages, and reproductive stages
collapse2 <- list(1:2, 3:4)
collapseMatrix(matU, matF, matC, collapse2)

}
\references{
Salguero-Gomez, R. & Plotkin, J. B. (2010) Matrix dimensions bias
  demographic inferences: implications for comparative plant demography. The
  American Naturalist 176, 710-722.
}
\seealso{
\code{\link{standardizeMatrix}}
}
\author{
Rob Salguero-Gómez <rob.salguero@zoo.ox.ac.uk>
}
