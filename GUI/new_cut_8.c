// graph generated on 2d images, 8 neighborhood.
// input: labels, fg, 
// output: bw
#include <math.h>
#include <mex.h>
#include <matrix.h>

// for examine the time-------------
#include <time.h>
#include <stdio.h>
#include <sys/types.h>
#include <sys/timeb.h>
#include <string.h>
//---------------------------------

void mexFunction(int nlhs, mxArray *plhs[],
				 int nrhs, const mxArray *prhs[])
{
	// for examine the time-------------
	// time_t ltime, start_time, end_time, start_time1, extratime1, extratime2, extratime, time0, time1, time2;
	// struct _timeb tstruct;
	//---------------------------------

	// create linked list for the lists LIST(k)={i, e(i)>delta/2, d(i)=k}
	
	struct myList
	{ long data;
	  struct myList * Next;
	};
	struct myList* minDisList;
	struct myList* currentList;
	struct myList testList;

	struct myList* List1;
	struct myList* List2;
	struct myList* currentNode;
	
	int dim_num, element_num, i,j,k,l, index, node_index, node_s_index, node_t_index,dim_num_fg,element_num_fg;
	int node_num,node_s_num,node_t_num;		// the number of node, node_s and node_t
	const int * dim_array, *dim_array_fg;					// dimension information of input and output matrix
	int *labels;						// input matrix
	double * pr1, *pr2, *output, *fg, * flow_output, temp_ew;			

	struct MyNODE 
	{
		int x,y;			// two coordinates of this node
		int index[8];		// index of its eight neighbors,  
		int edgeweight[10];	// edgeweight of corresponding neighbors, if neighbor is s or t, put it in 9th and 10th cell
	};

	struct MyNODE *node, *node_s, *node_t;
	struct MyNODE test_node;
	
	int *node_s_edgeweight, *node_t_edgeweight;	// edgeweight of corresponding neighbors, 
												// 0--node_num-1 correspond to node, 
												// node_num correspond to node_t or node_s
	
	int * matrix_index;

	int index1,index2,index3,index4,index5,index6,index7,index8;
	int edgeweight,my_direct;

	int * label, *pred, *list, *d, *numb, *cut;		//numb indicate the number of nodes of each distance
	long * e, sum,delta, U, flow;
	int N, current_d, flag, kk, breaked;
	int admissible, admissible_here, admissible_there, min_d, push_amount;

	//-------------------
	//extratime=0;
	//time( &ltime );
	//start_time1=ltime;
	//--------------------

	// get input
	if (nrhs != 2)
		mexErrMsgTxt("Two input arguments required.");
	if (nlhs != 2)
		mexErrMsgTxt("Two output arguments required.");
	if (!(mxIsDouble(prhs[0])))
		mexErrMsgTxt("Input array must be of type double.");
	
	dim_num=mxGetNumberOfDimensions(prhs[0]);       //每一维多少个元素
	dim_array=mxGetDimensions(prhs[0]);            //数组维数
	element_num=mxGetNumberOfElements(prhs[0]);   //数组元素个数

	if (dim_num != 2)
		mexErrMsgTxt("The input is not 2-D data.");
	dim_num_fg=mxGetNumberOfDimensions(prhs[1]);
	dim_array_fg=mxGetDimensions(prhs[1]);
	element_num_fg=mxGetNumberOfElements(prhs[1]);    //prhs 0和prhs 1的区别
	if (dim_num_fg != 3)
		mexErrMsgTxt("The input is not 3-D data.");

	labels = mxCalloc(element_num,sizeof(int));
	fg = mxCalloc(element_num_fg, sizeof(double));
	matrix_index = mxCalloc(element_num, sizeof(int));

	pr1 = (double *)mxGetPr(prhs[0]);
	pr2 = (double *)mxGetPr(prhs[1]);

	node_num=0;node_s_num=0;node_t_num=0;
	for (i=0;i<element_num;i++)              //循环1 
	{
		labels[i]=(int)pr1[i];
		//fg[i]=pr2[i];
		switch (labels[i])
		{
		case 1:
			node_num ++;
			break;
		case 2:
			node_s_num++;
			break;
		case 3:
			node_t_num++;
			break;
		default:
			break;
		}
	}
	 
	for (i=0;i<element_num_fg;i++)
	{
		fg[i]=pr2[i];
	}

/*	mexPrintf("num:%d",element_num_fg);
	mexPrintf("dim: %d,%d,%d\n",dim_array_fg[0],dim_array_fg[1],dim_array_fg[2]);
    mexPrintf("fg:%d,%d\n",(int)fg[0],(int)fg[7]);
	return;*/

	node = mxCalloc(node_num,sizeof(test_node));
	node_s = mxCalloc(node_s_num,sizeof(test_node)); 
	node_t = mxCalloc(node_t_num,sizeof(test_node)); 
	node_s_edgeweight = mxCalloc(node_num+1, sizeof(int));	// see its declaration
	node_t_edgeweight = mxCalloc(node_num+1, sizeof(int));

	// assign the nodes one by one into node, node_s and node_t according to the labels value.
	// matrix_index connected the index in 3d matrix with the index in the arrays of node, node_s and node_t
	// NOTE here: if the value of matrix_index entry is 0, it has different means, so when using matrix_index,
	//            people should also check the labels. 
	node_index=0;node_s_index=0;node_t_index=0;
	for (j=0; j<dim_array[1]; j++)                           //循环2
		for (i=0; i<dim_array[0]; i++)
		{
			index=j*dim_array[0]+i;
			switch (labels[index])
			{
			case 1:
				node[node_index].x=i;
				node[node_index].y=j;
	  			matrix_index[index]=node_index++;	
				break;
			case 2:
				node_s[node_s_index].x=i;
				node_s[node_s_index].y=j;
				matrix_index[index]=node_s_index++;
				break;
			case 3:
				node_t[node_t_index].x=i;
				node_t[node_t_index].y=j;
				matrix_index[index]=node_t_index++;
				break;
			default:
				break;
			}
		}

	// assign the edgeweight to the nodes

	for(node_index=0;node_index<node_num;node_index++)   //循环3
	{
		i=node[node_index].x;
		j=node[node_index].y;
				
		index2=j*dim_array[0]+i;
		// for each pair of neighbored nodes, assign the edgeweight between them,
		// for each node, first find out its eight neighbors, if the neighbor is one of the graph nodes,
		// then record the index number in .index[i] and edgeweight in the corresponding .edgweight[i]
		// where 0<=i<=7, if the neighbor is node_s, add the edgeweight to .edgeweight[8], and add the same
		// value to node_s_edgeweight[node_index];

		// NOTE: we don't assign edgeweight if the original node is node_s or node_t, because if the original 
		//		node is node_s, and if its neighbor is a node, the edgeweight have already been updated. !!! this is wrong when
		//   there is edge connecting node_s to node_t and we calculate the flow, so we need to assign edgeweight for node_s or node_t
		// BUT REMEMBER: We assume there is no direct link from node_s to node_t!
		// NOTE here: the assigned index value could be 0, which has ambiguous meaning, one is the first entry
		//	          of node, the other is the defaultly set zero.

		// Modification here: use directional gradient as edgeweight
		index1=0;
		for (l=j-1;l<=j+1;l++)
			for(k=i-1;k<=i+1;k++)
				if(!(k==i && l==j))
				{
					index=l*dim_array[0]+k;
					if (l==j) //same line
						my_direct=0;
					if (k==i)
						my_direct=1;
					if ((l-j)*(k-i)>0)
						my_direct=3;
					if ((l-j)*(k-i)<0)
						my_direct=2;
					//my_direct=4;

					temp_ew=(fg[index+my_direct*element_num]+fg[index2+my_direct*element_num]);
					temp_ew *= temp_ew*temp_ew;
					temp_ew *= temp_ew;
					edgeweight=(int)temp_ew;      //has a problem
					switch(labels[index])
					{
					case 1:
						node[node_index].index[index1]=matrix_index[index];
						node[node_index].edgeweight[index1]=edgeweight;
						break;
					case 2:
						node[node_index].edgeweight[8]+=edgeweight;
						node_s_edgeweight[node_index] +=edgeweight;
						break;
					case 3:
						node[node_index].edgeweight[9]+=edgeweight;
						node_t_edgeweight[node_index] +=edgeweight;
						break;
					default:
						break;
					}
					index1=index1++;
				}
	}			

	// assign the edgeweight for the edges linking node_s and node_t

	for(node_s_index=0;node_s_index<node_s_num;node_s_index++)
	{
		i=node_s[node_s_index].x;
		j=node_s[node_s_index].y;
				
		index2=j*dim_array[0]+i;
		for (l=j-1;l<=j+1;l++)
			for(k=i-1;k<=i+1;k++)
				if(!(k==i && l==j))
				{
					index=l*dim_array[0]+k;
					if (labels[index]==3)
					{
					if (l==j) //same line
						my_direct=0;
					if (k==i)
						my_direct=1;
					if ((l-j)*(k-i)>0)
						my_direct=3;
					if ((l-j)*(k-i)<0)
						my_direct=2;
					//my_direct=4;

					temp_ew=(fg[index+my_direct*element_num]+fg[index2+my_direct*element_num]);
					temp_ew *= temp_ew*temp_ew;
					temp_ew *= temp_ew;
					edgeweight=(int)temp_ew;
					
					node_s_edgeweight[node_num] +=edgeweight;
					node_t_edgeweight[node_num] +=edgeweight;
					}
				}
	}			

	//-------------------
	//time( &ltime );
	//end_time=ltime;
	//extratime = end_time-start_time1;
	//--------------------		

	//--------------------------------------------------------------------------------				
	
	//----------------------------------------------------------
	//s-t minimum cut using excess scaling preflow push algorithm
    //-----------------------------------------------------------


	//initialization
	N = node_num+2;							// for the flollowing arrays, 0th entry is node_s, 1,...,node_num are node
	label = mxCalloc(N,sizeof(int));			// N-1 th entry is node_t
	pred = mxCalloc(N,sizeof(int));
	list = mxCalloc(N,sizeof(int));
	e = mxCalloc(N,sizeof(double));			// excess
	d = mxCalloc(N,sizeof(int));			// distance
	flow = 0L;								// flow value

	minDisList = mxCalloc(2*N,sizeof(testList));	// distance list
	for (i=0;i<2*N;i++)
	{
		minDisList[i].data=i;
		minDisList[i].Next=(struct myList *)NULL;
	}

	//preprocessing
	label[N-1]=1;
	d[N-1]=0;
	index1 = 0;
	index2 = 0;
	list[index1]=N-1;



	// get distance label of each node
	currentNode = mxCalloc(1,sizeof(testList));
	currentNode->data = N-1; //the sink
	currentNode->Next = (struct myList *)NULL;
	List1=currentNode;
	List2=(struct myList *)NULL;
	current_d=1;
	while(List1!=NULL)
	{
		j=List1->data;
	//	mexPrintf("data is %ld \n",j);
		// if current node is node_t
		if (j==N-1)
		{
			for (i=0;i<node_num;i++)
				if (node[i].edgeweight[9]>0 && label[i+1]==0)	//this node is unlabeled and is linked to node_t 
				{
					d[i+1]=current_d;
					label[i+1]=1;
					currentNode = mxCalloc(1,sizeof(testList));
					currentNode->data = i+1;
					currentNode->Next = List2;
					List2 = currentNode;
				}
			if (node_t_edgeweight[node_num]>0 && label[0]==0)		// node_s is linked to node_t
			{
				index2=0;
				d[index2]=current_d;
				label[index2]=1;
				currentNode = mxCalloc(1,sizeof(testList));
				currentNode->data = index2;
				currentNode->Next = List2;
				List2 = currentNode;
			}
		}

		// if current node is node_s
		if (j==0)
		{
			for (i=0;i<node_num;i++)
				if (node[i].edgeweight[8]>0 && label[i+1]==0)	//this node is unlabeled and is linked to node_s 
				{
					d[i+1]=current_d;
					label[i+1]=1;
					currentNode = mxCalloc(1,sizeof(testList));
					currentNode->data = i+1;
					currentNode->Next = List2;
					List2 = currentNode;
				}
		}

		//if current node is node
		if (j!=0 && j!=N-1)
		{
			for (i=0;i<8;i++)
			{
				if (node[j-1].edgeweight[i]>0 && label[node[j-1].index[i]+1]==0)	//this node is unlabeld and linked to current node
				{
					index2=node[j-1].index[i]+1;
					d[index2]=current_d;
					label[index2]=1;
					currentNode = mxCalloc(1,sizeof(testList));
					currentNode->data = index2;
					currentNode->Next = List2;
					List2 = currentNode;
				}
			}
			if (node[j-1].edgeweight[8]>0 && label[0]==0)	// node_s is unlabeled and is linked to the current node
			{
				index2=0;
				d[index2]=current_d;
				label[index2]=1;
				currentNode = mxCalloc(1,sizeof(testList));
				currentNode->data = index2;
				currentNode->Next = List2;
				List2 = currentNode;
			}

		}

		List1=List1->Next;
		if (!List1)
		{
			current_d += 1;
			List1=List2;
			List2=(struct myList *)NULL;
		}
	}

/*	
	while(index2<N-1 && index1<=index2)
	{
		j=list[index1];
		current_d=d[j]+1;
		if(label[0]==0 && j>0 && node_s_edgeweight[j-1]>0)	// consider node_s
		{
			d[0]=current_d;
			label[0]=1;
			index2++;
			list[index2]=0;
		}
		for (i=1;i<N-1;i++)									// consider node
		{
			if(label[i]==0)										// unlabeled		
			{	
				flag=0;
				if (j==N-1 && node[i-1].edgeweight[9]>0)			// current one is node_t
					flag=1;
				if (j==0 && node[i-1].edgeweight[8]>0)				// current one is node_s
					flag=1;
				if (j>0 && j<N-1)									// current one is node
					for(k=0;k<8;k++)								
					{
						if(node[i-1].index[k]==j-1 && node[i-1].edgeweight[k]>0)	// the first judgement may not be enough
						{															// because a lot of index is 0, it doesn't				
							flag=1;													// mean it connect to the node 1.
							break;
						}
					}
				
				if(flag)
					//&& isConnected(i,j,node,node_s_edgeweight, node_t_edgeweight))  //isConnected check whether node i and node j are connected
				{
					d[i]=current_d;
					label[i]=1;
					index2++;
					list[index2]=i;
				}
			}
		}
		index1++;
	}
*/

	
	//in case some node is not connected to t,	
	for(i=0;i<N-2;i++)
	    if(d[i]==0)
		    d[i]=N;

	d[0]=N;

	// initially assign the excess
	sum=0;
	for(i=1;i<N-1;i++)
	{
		e[i]=node_s_edgeweight[i-1];			// e[i] should bigger than 0, but here, it doesn't matter
		node_s_edgeweight[i-1] -= e[i];
		node[i-1].edgeweight[8] += e[i];
		sum += e[i];
	}
	//i=N-1
	e[N-1]=node_s_edgeweight[N-2];
	node_s_edgeweight[N-2] -= e[N-1];
	node_t_edgeweight[N-2] += e[N-1];
	sum += e[N-1];

	e[0] = -sum;
	flow += e[N-1];
	e[N-1]=0;

	// numb is to count the number of nodes with the distance equal to the index numb array
	numb = mxCalloc(N*2,sizeof(int));

	for(i=0;i<N-2;i++)
		numb[d[i]] += 1;

	// excess scaling
	U=0;		
	for(i=0;i<node_num;i++)
		for(j=0;j<8;j++)
			if(U<node[i].edgeweight[j])
				U=node[i].edgeweight[j];		// get the largest edgeweight
			
	for(i=0;i<node_num+1;i++)
	{
		if(U<node_s_edgeweight[i])
			U=node_s_edgeweight[i];
		if(U<node_t_edgeweight[i])
			U=node_t_edgeweight[i];
	}

	//-------------------
	//time( &ltime );
	//end_time=ltime;
	//extratime1= end_time-start_time1;
	//----------------------------------
	
	delta=2<<(int)(log10(U)/log10(2));
	//time0=0L;time1=0L;time2=0L;
	while(delta>=1)
	{
		// construct the distance list for locating node with minimum distance
		//-------------------
		//time( &ltime );
		//start_time=ltime;
		//--------------------
		for(i=1;i<N-1;i++)
		{
			if (e[i]>delta/2)
			{
				currentList = mxCalloc(1,sizeof(testList));
				currentList->data=i;
				currentList->Next=minDisList[d[i]].Next;
				minDisList[d[i]].Next=currentList;
				//mexPrintf("%ld,",minDisList[d[i]].Next->data);
			}
		}

		flag=0;
		// locate the node with the minimum distance 
		for (i=1;i<N;i++)
			if (minDisList[i].Next)
			{
				currentList=minDisList[i].Next;
				flag=currentList->data;
				break;
			}

		//-------------------
		//time( &ltime );
		//end_time=ltime;
		//time0 += end_time-start_time;
		//--------------------
		//mexPrintf("\n flag=%d",flag);
/*		// find out is there any excess bigger than delta/2, if yes, take the one with smallest distance label
		flag=0;
		for(i=1;i<N-1;i++)
		{
			if(e[i]>delta/2)
			{
				if(d[i]<d[flag])
					flag=i;
			}
		}
*/
		// mexPrintf("delta=%d,flag=%d,N=%d, d=%d **",delta,flag,N, d[flag]);

/*		mexPrintf("\n");
		for(i=0;i<N;i++)
			mexPrintf("e[%d]=%d ",i,e[i]);
		mexPrintf("\n");
		for(i=0;i<N;i++)
			mexPrintf("d[%d]=%d ",i,d[i]);
		for(i=1;i<10;i++)
		{
			mexPrintf("\n numb[%d]=%d, data=%d",i,numb[i], minDisList[i].data);
			currentList=minDisList[i].Next;
			while(currentList)
			{
				mexPrintf(" %ld ",currentList->data);
				currentList=currentList->Next;
			}
		}
		mexPrintf("\n I am here!");*/
		while(flag )		// has node with excess bigger than delta/2
		{	
			//-------------------
			//time( &ltime );
			//start_time=ltime;
			//--------------------

			admissible=N;
			min_d=3000000;
			breaked=0;
			for(i=0;i<8;i++)	// check the neighbor of this node
			{
		//		mexPrintf("d[%d]=%d node=%d ",i,d[node[flag-1].index[i]+1],node[flag-1].edgeweight[i]);
				if(node[flag-1].edgeweight[i]>0)	// has edgeweight > 0, from flag-1 to its neighbor
				{
					if(d[flag]-d[node[flag-1].index[i]+1]==1)	// distance label is proper
					{
						admissible=node[flag-1].index[i]+1;		// set the neighbor to be admissible
						admissible_here=i;						// remember which direction this neighbor is
						breaked=1;		
						break;									// break out of for-loop
					}
					else										// find out the minimum distance label of its neighbors
					{
						if(d[node[flag-1].index[i]+1]<min_d)
							min_d=d[node[flag-1].index[i]+1];
					}
				}
			}
			if(node[flag-1].edgeweight[8]>0 && !breaked)		// check if node_s is neighbor
			{
				if(d[flag]-d[0]==1)
				{
					admissible=0;
					admissible_here=8;
					breaked=1;
				}
				else
				{
					if(d[0]<min_d)
						min_d=d[0];
				}
			}

			if(node[flag-1].edgeweight[9]>0 && !breaked)		// check if node_t is neighbor
			{
				if(d[flag]-d[N-1]==1)
				{
					admissible=N-1;
					admissible_here=9;
				}
				else
				{
					if(d[N-1]<min_d)
						min_d=d[N-1];
				}
			}

			if (admissible!=N)									// admissible node exists
			{
				
				push_amount=node[flag-1].edgeweight[admissible_here];
				if (push_amount>e[flag])
					push_amount=e[flag];
				if (push_amount>delta-e[admissible])
					push_amount=delta-e[admissible];			// find the minimum of the three
				e[flag] -= push_amount;
				//if e[flag] still > delta/2, keep it in the minDisList, if not, delete it from the list
				if (e[flag]<=delta/2)
				{
					currentList=minDisList[d[flag]].Next;
					//link to the next
					minDisList[d[flag]].Next=currentList->Next;
					//free memory
					//mexPrintf("here\n");
					//free(currentList);
					//mexPrintf("there\n");
				}
				
				e[admissible] += push_amount;
				// the old e[admissible] should be small than delta/2, or since it has less excess, it will be checked already
				// so, if e[admissible] is greater than delta/2, add it into minDisList
				//Note: this admissible should not be the node_t
				if (e[admissible]> delta/2 && admissible!=N-1)
				{
					currentList=mxCalloc(1,sizeof(testList));
					currentList->data=admissible;
					currentList->Next=minDisList[d[admissible]].Next;
					minDisList[d[admissible]].Next=currentList;
				}

				node[flag-1].edgeweight[admissible_here] -= push_amount;
				if (admissible_here<8)
				{
					admissible_there=7-admissible_here;
					node[admissible-1].edgeweight[admissible_there] +=push_amount;
				}
				if (admissible_here==8)
					node_s_edgeweight[flag-1] += push_amount;
				if (admissible_here ==9)
					node_t_edgeweight[flag-1] += push_amount;
				
				flow +=e[N-1];e[N-1]=0;
			}
			else		// admissible node doesn't exist
			{   
				numb[d[flag]]=numb[d[flag]]-1;
				k=d[flag];
			
				if (numb[k]==0)
				{
					for (kk=0;kk<N;kk++)
					{
						if (d[kk]>k && d[kk]!=N)		// for all those nodes can not reach node_t
						{
							numb[d[kk]]=numb[d[kk]]-1;
							d[kk]=N;
							// e[kk]=e[0];
							numb[N]=numb[N]+1;
						}
					}
					for (kk=k;kk<N;kk++)
						minDisList[kk].Next=(struct myList *)NULL;			
				}
				else
				{

					// delete it from the list at old d[flag]
					//link to the next
					currentList=minDisList[d[flag]].Next;
					minDisList[d[flag]].Next=currentList->Next;
	
					d[flag]=min_d+1;
					k=d[flag];
					// add it to the list at new d[flag]
					currentList->data=flag;
					currentList->Next=minDisList[d[flag]].Next;
					minDisList[d[flag]].Next=currentList;
	
					// change numb
					numb[k]=numb[k]+1;
				}
			}
			//-------------------
			//time( &ltime );
			//end_time=ltime;
			//time1 += end_time-start_time;
			//--------------------

			//-------------------
			//time( &ltime );
			//start_time=ltime;
			//--------------------

			flag=0;
			// locate the node with the minimum distance 
			for (i=1;i<N;i++)
				if (minDisList[i].Next)
				{
					currentList=minDisList[i].Next;
					flag=currentList->data;
					break;
				}

			//-------------------
			//time( &ltime );
			//end_time=ltime;
			//time2 +=end_time-start_time;
			//--------------------

			
		}
		
		delta=(long) delta/2;
	}



  //	mexPrintf("flow=%ld\n",flow);
		
	cut = mxCalloc(N,sizeof(int));
	cut[0]=1;						// node_s belong to S part
	for (i=1;i<N;i++)
		if (d[i]>=N)
			cut[i]=1;				// mark other nodes of S part

	//prepare the output matrix

	plhs[0]=mxCreateNumericArray(2, dim_array, mxDOUBLE_CLASS, mxREAL);
	output=mxGetPr(plhs[0]);

	plhs[1] = mxCreateDoubleMatrix(1,1,mxREAL);
	flow_output = mxGetPr(plhs[1]);
	* flow_output = (double) flow;

	for (i=1;i<N-1;i++)
	{
		index=node[i-1].y*dim_array[0]+node[i-1].x;
		if (cut[i]==1)
			labels[index]=2;
		else
			labels[index]=3;
	}

	for (j=1; j<dim_array[1]-1; j++)
		for (i=1; i<dim_array[0]-1; i++)
		{
			index=j*dim_array[0]+i;
			if (labels[index]==2)
			{ 
				index1=j*dim_array[0]+i+1;
				index2=j*dim_array[0]+i-1;
				index3=(j+1)*dim_array[0]+i;
				index4=(j-1)*dim_array[0]+i;
				index5=(j+1)*dim_array[0]+i+1;
				index6=(j-1)*dim_array[0]+i-1;
				index7=(j+1)*dim_array[0]+i-1;
				index8=(j-1)*dim_array[0]+i+1;
				if(labels[index1]==3 ||labels[index2]==3 ||labels[index3]==3 ||labels[index4]==3 ||labels[index5]==3 ||labels[index6]==3 ||labels[index7]==3 ||labels[index8]==3 )
					output[index]=1;
			}
		}

	//-------------------
	//time( &ltime );
	//end_time=ltime;
	//extratime2= end_time-start_time1;
	//----------------------------------
	//mexPrintf("\n extratime=%ld, extratime1=%ld, extratime2=%ld, time0=%ld, time1=%ld, time2=%ld",extratime,extratime1,extratime2,time0,time1,time2);

}
