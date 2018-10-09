// graph generated on 2d images, 8 neighborhood.
// input: labels which is     0   2   1 
// output: labels which is		2 1 3

#include <math.h>
#include <mex.h>
#include <matrix.h>

void mexFunction(int nlhs, mxArray *plhs[],
				 int nrhs, const mxArray *prhs[])
{
	int dim_num, element_num, i,j,k,l, index;
	const int * dim_array;					// dimension information of input and output matrix
	int *labels;						// input matrix
	double * pr1, *output;		
	int index1,index2,index3,index4,index5,index6,index7,index8;

	// get input
	if (nrhs != 1)
		mexErrMsgTxt("One input argument required.");
	if (nlhs > 1)
		mexErrMsgTxt("Too many output arguments.");
	if (!(mxIsDouble(prhs[0])))
		mexErrMsgTxt("Input array must be of type double.");
	
	dim_num=mxGetNumberOfDimensions(prhs[0]);
	dim_array=mxGetDimensions(prhs[0]);
	element_num=mxGetNumberOfElements(prhs[0]);

	if (dim_num != 2)
		mexErrMsgTxt("The input is not 2-D data.");

	labels = mxCalloc(element_num,sizeof(int));

	pr1 = (double *)mxGetPr(prhs[0]);

	for (i=0;i<element_num;i++)
	{
		labels[i]=(int)pr1[i];
	}

	//prepare the output matrix

	plhs[0]=mxCreateNumericArray(2, dim_array, mxDOUBLE_CLASS, mxREAL);
	output=mxGetPr(plhs[0]);

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
				if(labels[index1]==0 ||labels[index2]==0 ||labels[index3]==0 ||labels[index4]==0 ||labels[index5]==0 ||labels[index6]==0 ||labels[index7]==0 ||labels[index8]==0 )
					output[index]=2;
				if(labels[index1]==1 ||labels[index2]==1 ||labels[index3]==1 ||labels[index4]==1 ||labels[index5]==1 ||labels[index6]==1 ||labels[index7]==1 ||labels[index8]==1 )
					output[index]=3;
				if(labels[index1]==2 &&labels[index2]==2 &&labels[index3]==2 &&labels[index4]==2 &&labels[index5]==2 &&labels[index6]==2 &&labels[index7]==2 &&labels[index8]==2 )
					output[index]=1;
			}
		}
}
