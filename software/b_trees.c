//
//  Author: David Billsbrough
// 
//  Created: Sunday, July 21, 2024 at 18:06:03 PM (EDT)
//
//  https://www.cprogramming.com/snippets/source-code/binary-tree-creation-traversal-and-search
//
//  $Id: b_trees.c,v 0.12 2024/07/22 02:03:09 kc4zvw Exp kc4zvw $
//

#include <stdio.h>
#include <stdlib.h>

struct tnode 
{
	int data;
	struct tnode *left;
	struct tnode *right;
};
 
typedef struct tnode TreeNode;
 
TreeNode *newItem(int data)
{
	TreeNode *pn = (TreeNode *) malloc(sizeof(TreeNode));
	pn->data = data;
	pn->left = 0;
	pn->right = 0;

	return pn;
}

TreeNode *insertTree(TreeNode *pn, int data)
{
	if (!pn)
		return newItem(data);
 
	else {
		if (data <= pn->data)
			pn->left = insertTree(pn->left, data);
 
		else 
			pn->right = insertTree(pn->right, data);
	}
 
	return  pn;
}
 
/* Added more numbers to binary tree then the original source */ 
 
TreeNode *createTree()
{
	TreeNode *pr = insertTree(0, 6);
	insertTree(pr, 1);
	insertTree(pr, 7);
	insertTree(pr, 2);
	insertTree(pr, 8);
	insertTree(pr, 3);
	insertTree(pr, 9);
	insertTree(pr, 5);
	insertTree(pr, 10);
	insertTree(pr, 4);
	insertTree(pr, 12 );
	insertTree(pr, 11 );
 
	return pr;
}
 
void printPreorder(TreeNode *pn)
{
	if (pn) {
		printf("preorder = %d\n", pn->data);
		printPreorder(pn->left);
		printPreorder(pn->right);
	}
}
 
void printPostorder(TreeNode *pn)
{
	if (pn) {
		printPostorder(pn->left);
		printPostorder(pn->right);
		printf("postorder = %d\n", pn->data);
	}
}
 
void printInorder(TreeNode *pn)
{
	if (pn) {
		printInorder(pn->left);
		printf("inorder = %d\n", pn->data);
		printInorder(pn->right);
	}
}
 
int size(TreeNode *pn)
{
	if (pn)
		return 1 + size(pn->left) + size(pn->right);
	
	else
		return 0;
}
 
int depth(TreeNode *pn)
{
	if (pn) {
		int ld = depth(pn->left);
		int rd = depth(pn->right);
 
		if (ld > rd)
			return ld + 1;
		else
		return rd + 1;
	} else
		return 0;
}
 
int minVal(TreeNode *pn)
{
    if (pn) {
        while (pn->left)
            pn = pn->left;
 
        return pn->data;
    } else
        return 0;
}
 
int maxVal(TreeNode *pn)
{
    if (pn) {
        while (pn->right)
            pn = pn->right;
 
        return pn->data;
    } else
        return 0;
}

int main(void)
{
	TreeNode *alpha;

	printf("\n");
	printf("Demonstration of a simple binary tree of integers.\n");
	printf("\n");

	alpha = createTree();

	printPreorder(alpha);
	printf("\n");
	printPostorder(alpha);
	printf("\n");
	printInorder(alpha);

	printf("\n");
	printf("End program\n");

	return 0;
}

// vim: syntax=c tabstop=4 nowrap:


/* End of File */
