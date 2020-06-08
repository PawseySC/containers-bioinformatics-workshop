    library(ggtree)
    library(treeio)

    treetext = "(((ADH2:0.1[&&NHX:S=human], ADH1:0.11[&&NHX:S=human]):
    0.05 [&&NHX:S=primates:D=Y:B=100],ADHY:
    0.1[&&NHX:S=nematode],ADHX:0.12 [&&NHX:S=insect]):
    0.1[&&NHX:S=metazoa:D=N],(ADH4:0.09[&&NHX:S=yeast],
    ADH3:0.13[&&NHX:S=yeast], ADH2:0.12[&&NHX:S=yeast],
    ADH1:0.11[&&NHX:S=yeast]):0.1[&&NHX:S=Fungi])[&&NHX:D=N];"

    tree <- read.nhx(textConnection(treetext))

    ggtree <- ggtree(tree) + geom_tiplab() + 
        geom_label(aes(x=branch, label=S), fill='lightgreen') + 
        geom_label(aes(label=D), fill='steelblue') + 
        geom_text(aes(label=B), hjust=-.5)

    if(interactive()) {
        # Interactive example
        print(ggtree)
    } else {
        # Run when used from command line
        ggsave("tree.png")
    }
    