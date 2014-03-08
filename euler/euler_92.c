#include <stdio.h>
#include <stdlib.h>

struct node {
	int val;
	struct node *next;
};

/* constructs a new node */
struct node *new_node(int val, struct node *next)
{
	struct node *new_node = (struct node*) malloc(sizeof(struct node));
	new_node->val = val;
	new_node->next = next;

	return new_node;
}

/* returns pointer to next field and frees memory for passed node */
struct node *free_current_return_next(struct node *to_free)
{
	struct node *to_return = to_free->next;
	free(to_free);
	return to_return;
}

int next_in_chain(int n)
{
	int sum = 0;
	int squares[10] = {0, 1, 4, 9, 16, 25, 36, 49, 64, 81};

	while(n > 0) {
		sum += squares[n%10];
		n /= 10;
	}

	return sum;
}

int euler_92(int cap)
{
	/* index array so that numbers[1] corresponds to 1 instead of 2 */
	/* int numbers[cap + 1]; */
	int numbers[cap > 1000?cap+1:1000];
	/* int numbers[10000000]; */
	int index = 1;

	int temp_index = 1;

	int count = 0;

	struct node *num_list = NULL;

	/* initilize numbers to 0 */
	for (temp_index = 0; temp_index < 1000; temp_index++) {
		numbers[temp_index] = 0;
	}

	numbers[1] = 1;
	numbers[89] = 89;

	for (index = 1; index < cap; index++) {
		/* printf("index = %d\n",index); */
		for (temp_index = index; numbers[temp_index] == 0; temp_index = next_in_chain(temp_index)) {
			/* build up linked list structure containing a list of numbers */
			/* printf("adding %d\n",temp_index); */
			num_list = new_node(temp_index, num_list);
		}
		/* printf("temp_index == %d ----- numbers[temp_index] == %d\n",temp_index, numbers[temp_index]); */
		/* traverse the linked list, so that numbers[val] = numbers[temp_index]; 
		 * !! make sure that val is below cap !! 
		 * free nodes of the list as traverse them */
		for (;num_list != NULL; num_list = free_current_return_next(num_list)) {
			if (num_list->val < cap) {
				/* printf("%d visits %d\n",num_list->val,numbers[temp_index]); */
				numbers[num_list->val] = numbers[temp_index];
			}
		}

	}

	/* traverse numbers and count how many are 89 */
	for (temp_index = 1; temp_index < cap; temp_index++) {
		if (numbers[temp_index] == 89){
			count++;
		}
	}

	return count;
}
int main()
{
	int cap = 10000000;

	/* printf("0->%d\n */
	/* 		1->%d\n */
	/* 		2->%d\n */
	/* 		3->%d\n */
	/* 		4->%d\n */
	/* 		5->%d\n */
	/* 		6->%d\n */
	/* 		7->%d\n */
	/* 		8->%d\n */
	/* 		9->%d\n", */
	/* 		next_in_chain(0), */
	/* 		next_in_chain(1), */
	/* 		next_in_chain(2), */
	/* 		next_in_chain(3), */
	/* 		next_in_chain(4), */
	/* 		next_in_chain(5), */
	/* 		next_in_chain(6), */
	/* 		next_in_chain(7), */
	/* 		next_in_chain(8), */
	/* 		next_in_chain(9)); */

	int count = euler_92(cap);

	printf("%d starting numbers below %d arrive at 89\n", count, cap);

	return 0;
}
