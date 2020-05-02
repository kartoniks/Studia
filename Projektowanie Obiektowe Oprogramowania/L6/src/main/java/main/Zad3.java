package main;

import java.time.LocalDate;
import java.time.LocalTime;


public class Zad3 {

    public Zad3() {
        TreeNode root = new TreeNode(
                new TreeNode( new TreeLeaf(1), new TreeLeaf(2)),
                new TreeLeaf(3)
        );
        System.out.println("Depth is: " + new TreeDepthVisitor().VisitTreeDepth(root));
    }

    public class Tree { }
    public class TreeNode extends Tree
    {
        public TreeNode(Tree l, Tree r){
            this.left = l;
            this.right = r;
        }
        public Tree left;
        public Tree right;
    }
    public class TreeLeaf extends Tree
    {
        public TreeLeaf(int v) {
            this.value = v;
        }
        public int value;
    }

    public class TreeDepthVisitor {
        public int depth;

        public int VisitTreeDepth(Tree tree) {
            this.Visit(tree, 0);
            return this.depth;
        }

        public void Visit(Tree tree, int depth) {
            if (tree instanceof TreeNode) {
                Visit(((TreeNode) tree).left,  depth+1);
                Visit(((TreeNode) tree).right, depth+1);
            }
            if(tree instanceof TreeLeaf) {
                if(depth > this.depth)
                    this.depth = depth;
            }
        }
    }
}



