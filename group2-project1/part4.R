# CSCI3907
# Project 1: Part 4
# Group 2: Matteo Sanchez-Dahl, Latifa Al Jlayel

## set up
library(igraph)
library(sna)

## set working directory 
setwd('/Users/latifaaljlayel/Documents/School/Academic/Fall 2022/CSCI 3907/Class Projects/Class Project 1/data_subelj_jdk')

## import data
nodes <- as.matrix(read.table(file='/Users/latifaaljlayel/Documents/School/Academic/Fall 2022/CSCI 3907/Class Projects/Class Project 1/data_subelj_jdk/ent_subelj_jdk_jdk_class_name.txt',header=TRUE))

# 1k edges 
edges <- as.matrix(read.table(file='/Users/latifaaljlayel/Documents/School/Academic/Fall 2022/CSCI 3907/Class Projects/Class Project 1/data_subelj_jdk/out_subelj_jdk_jdk.txt', sep = "", header = F, skip = 2))

## convert the edgelist to an igraph object
net <- graph_from_edgelist(edges, directed = TRUE)

#eigen centrality
eigen_centrality(net, directed = FALSE, scale = TRUE, weights = NULL, options = arpack_defaults)

#maximum cardinality
max_cardinality(net)

#reciprocity
reciprocity(net, ignore.loops = TRUE, mode = c("default", "ratio"))

#node strength
strength(net)

#min_cut
min_cut(net, source = NULL, target = NULL, capacity = NULL, value.only = TRUE)

#k-core of a graph
coreness(net, mode = c("all", "out", "in"))

#global efficiency in a network
global_efficiency(net, weights = NULL, directed = TRUE)

#component distribution
is_connected(net, mode = c("weak", "strong"))
count_components(net, mode = c("weak", "strong"))

#smallest eccentrity in a graph
radius(net, mode = c("all", "out", "in", "total"))

#head of edges in a graph
head_of(net, edges)

#size of graph (# of edges)
gsize(net)

#graph version
graph_version(net)

#directed acyclic graphs
is_dag(net)

#checks to see if the graph is directed
is_directed(net)

#checks the tail of graph's edges for undirected graphs
tail_of(net, edges)

