# CSCI3907
# Project 1
# Group 2: Matteo Sanchez-Dahl, Latifa Al Jlayel

## set up
install.packages("igraph")
library(igraph)

install.packages("sna")
library(sna)

## set working directory 
setwd('/Users/matteosanchez-dahl/Desktop/F2022/CSCI 3907/group2-project1')

## import data
nodes <- as.matrix(read.table('data_subelj_jdk/ent_subelj_jdk_jdk_class_name.txt'))

edges <- as.matrix(read.table('data_subelj_jdk/out_subelj_jdk_jdk.txt', sep = "", header = F, skip = 2, nrows = 1000))
edges

## convert the edgelist to an igraph object
# graph_from_edgelist(el, directed = TRUE)
mygraph <- graph_from_edgelist(edges, directed = TRUE)
mygraph

## graph
# plot graph 
plot.igraph(mygraph)

# get the vertices of a graph
V(mygraph)

# get the edges of a graph
E(mygraph)

# get the adjacency matrix
mygraph.adj <- as_adjacency_matrix(mygraph)
mygraph.adj

## graph analytics functions

# Density
# gden 
# gden(dat, g=NULL, diag=FALSE, mode="digraph", ignore.eval=FALSE)
mygraph.density = gden(edges, mode = "digraph")
mygraph.density

# edge density 
edge_density(mygraph)

edge_density(mygraph, loops = T)

### TODO ###
# egocentric network
mygraph.ego <- ego.extract(edges)
# Error: vector memory exhausted (limit reached?)

### TODO ###
mygraph.ego[1]
mygraph.ego[50]
###########

# degree
degree(mygraph)

## centrality metrics

# betweeness centrality
centr_betw(mygraph)

# closeness centrality
centr_clo(mygraph)
# is NaN an acceptable value result?

## shortest path

# length of the shortest path between any two nodes in a graph g
mygraph.sp <- shortest.paths(mygraph)
mygraph.sp

# get the actual paths (and not just their length) 
get.shortest.paths(mygraph,1)

## geodist
mygraph.gd <- geodist(edges)
mygraph.gd


## number of paths between two nodes
# can multiply the adjacency matrix by itself. The cell numbers specify the number of paths
mygraph.np <- mygraph.adj*mygraph.adj
mygraph.np

## histogram of the degree of the nodes
hist(degree(mygraph))

