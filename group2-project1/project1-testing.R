# CSCI3907
# Project 1
# Group 2: Matteo Sanchez-Dahl, Latifa Al Jlayel

## set up
install.packages("igraph")
library(igraph)

install.packages("sna")
library(sna)

## set working directory 
setwd('/Users/matteosanchez-dahl/Desktop/F2022/CSCI 3907/projects/project1/group2-project1')

## import data
nodes <- as.matrix(read.table('data_subelj_jdk/ent_subelj_jdk_jdk_class_name.txt'))

# 1k edges 
# edges <- as.matrix(read.table('data_subelj_jdk/out_subelj_jdk_jdk.txt', sep = "", header = F, skip = 2, nrows = 1000))
edges <- as.matrix(read.table('data_subelj_jdk/out_subelj_jdk_jdk.txt', sep = "", header = F, skip = 2))
edges

## convert the edgelist to an igraph object
# graph_from_edgelist(el, directed = TRUE)
net <- graph_from_edgelist(edges, directed = TRUE)
net

V(net)$name <- nodes

## graph
# v1
plot(net, vertex.label = nodes)

##
is.simple.(net)

net_simple = simplify(net,
                      remove.multiple = TRUE,
                      remove.loops = TRUE,
                      edge.attr.comb = "concat"
                      )

plot(net_simple, vertex.label = nodes)

histogram <- hist(igraph::degree(net))

histogram_simple <-hist(igraph::degree(net_simple))

mynet <- V(net_simple)
mynet11 <- V(net_simple)[igraph::degree(net_simple)<5000]
mynet11


##

# plot graph 
plot.igraph(net)

# get the vertices of a graph
V(net)

# get the edges of a graph
E(net)

# get the adjacency matrix
net.adj <- as_adjacency_matrix(net)
net.adj

## graph analytics functions

# Density
# gden 
# gden(dat, g=NULL, diag=FALSE, mode="digraph", ignore.eval=FALSE)
net.density = gden(edges, mode = "digraph")
net.density

# edge density 
igraph::edge_density(net)

igraph::edge_density(net, loops = T)
# there are no loops in the graph => same edge density

### TODO ###
# egocentric network
net.ego <- ego.extract(edges)
# Error: vector memory exhausted (limit reached?)

### TODO ###
net.ego[1]
net.ego[50]
###########

# degree
igraph::degree(net)

## centrality metrics

# betweeness centrality
centr_betw(net)

# closeness centrality
centr_clo(net)
# is NaN an acceptable value result?

## shortest path

# length of the shortest path between any two nodes in a graph g
net.sp <- shortest.paths(net)
net.sp

# get the actual paths (and not just their length) 
get.shortest.paths(net,1)

## geodist
net.gd <- geodist(edges)
net.gd


## number of paths between two nodes
# can multiply the adjacency matrix by itself. The cell numbers specify the number of paths
net.np <- net.adj*net.adj
net.np

## histogram of the degree of the nodes
hist(degree(net))

# edge density 
igraph::edge_density(net)

igraph::edge_density(net, loops = T)
# there are no loops in the graph => same edge density

# diameter
net.d <- igraph::diameter(net)
net.d

# max cliques for node 13 
node13 <- c(13)
net.13clique <- igraph::max_cliques(net, min = NULL, subset = node13)
# At core/cliques/maximal_cliques_template.h:269 : Edge directions are ignored for maximal clique calculation.
net.13clique

# largest cliques
net.lgcliques <- igraph::clique_num(net)
# At core/cliques/maximal_cliques_template.h:269 : Edge directions are ignored for maximal clique calculation.
net.lgcliques

# Exercise: Try to identify the cliques in the plot. Write them down.

# name vertices
V(net)$name

# plot
plot(net)
