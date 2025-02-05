# Max Seenisamy Jan 30, 2025
# To Understand Post Quantum Crypto - First we have to generate a Lattice with 2 vectors, to understand
# the foundational math problem that makes Lattice Crypto the best choice for Post Quantum
# https://www.mathworks.com/matlabcentral/answers/479349-plotting-a-2d-crystal-lattice-from-two-primitive-lattice-vectors

# STEP 1: DEFINE THE VECTORS FROM WHICH WE ARE GENERATING A LATTICE
# vector1 = (v1x, v1y)
# vector1 = [-1/97, 22/7 ];
# easy one to visualize
vector1 = [0, 1 ];

# vector2 = (v2x, v2y)
# vector2 = [ 0.768 , -14/sqrt(53)];
# easy one to visualize
vector2 = [1, 0 ];

#STEP 2 : DEFINE A SET OF MOVES FOR THE VECTORS TO GENERATE LATTICE POINTS
# generate a 2-D grid with moves for each vector, to generate lattice points using those 2 vectors
# this grid is also a mechanism to generate a series of moves for each vectors to generate lattice points
# meshgrid returns 2 matrices back and get assigned to x and y
[v1moves,v2moves] = meshgrid(0:10,0:10);
# 0:10 means 11 and 0:5 means 6, so this will allow to generate 66 lattice points
# this means we have to generate 66 pairs of (v1m, v2m), one for each lattice point
# 0 to 10 for one vector's one axis (read v1x), each move, v1m as one column and 6 repeated rows AND
# 0 to 5 for the other vector's same axis (read v2x ), each move v2m as one row and 11 repeated columns

#STEP 3 : MAKE THE LATTICE POINT GENERATOR AS MATRIX OF VALUES (v1m, v2m)
# we need 66 pairs of (v1m, v2m) that are all unique
# substep - collapse all values into 1 column of 66 values on both the move matrices
# v1moves(:) makes one matrix with one column and 66 rows so does v2moves(:)
% make one "Lattice Point Generator" matrix with 2 columns, where col1 = v1m and col2 = v2m
#    v1m (1st col) moves 0 to 10 and v1m iterates from 0 to 5 for every value in v1m
Lxygenerator = [v1moves(:),v2moves(:)];

#STEP 4 : PREP THE VECTORS AS 2 ROWS OF VECTORS TO MULTIPLY WITH THE LATTICE POINT GENERATOR FROM STEP 3
RowsofVectors = [vector1;vector2];

#STEP 5 : GENERATE THE LATTICE POINTS
# lets say the vectors are v1(0,1) and v2(1,0) --> this is easy to mentally picture
# Generator pair (v1m, v2m) e,g,(1,0),(2,1),(10,4),(3,5) etc - note v1m 0:10 and v2m 0:5 from meshgrid
# Lattice point = (v1m) * v1 + (v2m) * v2
# (10,4) move   = ((10 *v1x + 10*v2x) , (4*v1y + 4*v2y))
#               = ((10 *0   + 10*1)   , (4*1   + 4*0))
#               = (10, 4) (remember this example is set just to easily visualize)
# from a Crypto perspective - the choices of these vectors should not allow easy
# visualization by just looking at the generated Lattice Points
LatticePoints = Lxygenerator*RowsofVectors;
#LatticePoints now holds all lattice points Lx in one column and Ly in second column
#calculated as Lx = v1x * v1m + v2x * v2m
#          and Lx = v1y * v1m + v2y * v2m using basic Matrix Multiplication

#STEP 5 : PLOT THE LATTICE TO VISUALIZE
# if we plot LatticePoints straight up, using plot - it won't visualize correctly
# why ? you will see v1m go from 0 to 10 as a straight line and v2m iterate from 0 to 5 like a saw tooth
# because we have both values arranged that way, in just one matrix
# substep - get the Lattice's all x-axis values into a matrix
Lx = reshape(LatticePoints(:,1),size(v1moves));
# substep - get the Lattice's all y-axis values into a matrix
Ly = reshape(LatticePoints(:,2),size(v2moves));
# NOW PLOT FOR THE LATTICE EFFECT, TRANSPOSE AND PLOT AGAIN
plot(Lx,Ly,'go--')
hold on
plot(Lx',Ly','b-')
axis equal
axis square
# You have a sold understanding of the math behind Post Quantum Cryptography
