struct node {
	int val;
	struct node *next;
};

int next_in_chain(n)
{
	int sum = 0;
	int squares[10] = {0, 1, 4, 9, 16, 25, 36, 49, 64, 81};

	while(n > 0) {
		sum += squares[sum%10];
		n /= 10;
	}

	return sum;
}

int main()
{
	int cap = 100;
	/* index array so that numbers[1] corresponds to 1 instead of 2 */
	int numbers[cap + 1];
	int index = 1;

	int temp_index = 1;

	int count = 0;

	/* initilize numbers to 0 */
	for (int i = 0; i < cap; i++) {
		numbers[i] = 0;
	}

	numbers[1] = 1;
	numbers[89] = 89;

	while (index < cap) {
		if (numbers[index] = 0) {
			temp_index = index;
			/* initilize linked list */
			for (; numbers[temp_index] = 0; temp_index = next_in_chain(temp_index)) {
				/* build up linked list structure containing a list of numbers */
			}
			/* traverse the linked list, so that numbers[val] = numbers[temp_index]; 
			 * !! make sure that val is below cap !! */

			/* free linked list structure */

		}
		index++;
	}

	/* traverse numbers and count how many are 89 */
	for (int i = 1; i < cap; i++) {
		if (numbers[i] = 89)
			count++;
	}

	printf("%d starting numbers below %d arrive at 89.", count, cap);

	return 0;
}
