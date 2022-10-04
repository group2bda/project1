# CSCI3907
# Project 1: Part 5
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

# a. determine central node(s) 
igraph::betweenness(net)

# b. get longest path(s) 
diameter(net, directed = TRUE, unconnected = TRUE, weights = NULL)

# c. get largest clique(s)
largest.cliques(net)

# d. determine ego(s)

ego_size(
  net,
  order = 1,
  nodes = V(net),
  mode = c("all", "out", "in"),
  mindist = 0
)

ego(
  net,
  order = 1,
  nodes = V(net),
  mode = c("all", "out", "in"),
  mindist = 0
)

make_ego_graph(
  net,
  order = 1,
  nodes = V(net),
  mode = c("all", "out", "in"),
  mindist = 0
)
ego(net)

# e. determine power centrality
power_centrality(
  net,
  nodes = V(net),
  loops = FALSE,
  exponent = 1,
  rescale = FALSE,
  tol = 1e-07,
  sparse = TRUE
)


