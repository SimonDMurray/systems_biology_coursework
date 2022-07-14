library(WGCNA)
library(Seurat)
library(Matrix)
library(SeuratDisk)
#Convert .h5ad file to a .h5seurat object that can be read into R as a Seurat object
Convert("results/top_mut_expression.h5ad", dest = "results/top_mut_expression.h5seurat", overwrite = TRUE)
top_mut_seur <- LoadH5Seurat("results/top_mut_expression.h5seurat")
#Extract expression matrix and covnert to a sparse matrix
top_mut_mat <- as(top_mut_seur@assays$RNA@counts, "sparseMatrix")
#Generate coexpression adjacency matrix
top_mut_adj <- adjacency(top_mut_mat)
#Produce edge and node files
exportNetworkToCytoscape(top_mut_adj, edgeFile="results/top_mut_edges.txt", nodeFile="results/top_mut_nodes.txt")
