function DownsampleMatrix=CreateCoarsener(M,N)%18.086 Final Project%By Joseph Kovac%Revised and submitted for OCW 9/12/05iM=M-2;%Number of interior rows, must be 2^c-1iN=N-2;%Number of interior columns, must be 2^c-1%Create a coarsening matrix of appropriate size via the stencil described%in the paperstencil=[1 2 1 zeros(1,M-3) 2 4 2 zeros(1,M-3) 1 2 1]/16;NumOutRows=(M-1)/2;NumOutCols=(N-1)/2;OutputPoints=[];for y=1:M    for x=1:N        if (rem(y,2)+rem(x,2)==0)            OutputPoints=[OutputPoints (x-1)*M+y];        end    endendOutputPoints=sort(OutputPoints);OutputMat=0*(speye(NumOutRows^2,M^2));for CurRow=1:NumOutRows^2    OutputMat(CurRow,OutputPoints(CurRow)-(M+1):OutputPoints(CurRow)+(M+1))=stencil;endDownsampleMatrix=OutputMat;