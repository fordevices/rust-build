# Max Seenisamy Jan 30, 2025
# To Understand Post Quantum Crypto - First we have to generate a Lattice with 2 vectors, to understand
# the foundational math problem that makes Lattice Crypto the best choice for Post Quantum

vector1 = [-1/97, 22/7 ];
vector2 = [ 0.768 , -14/sqrt(53)];
[v1moves,v2moves] = meshgrid(0:10,0:10);
Lxygenerator = [v1moves(:),v2moves(:)];
RowsofVectors = [vector1;vector2];
LatticePoints = Lxygenerator*RowsofVectors;
Lx = reshape(LatticePoints(:,1),size(v1moves));
Ly = reshape(LatticePoints(:,2),size(v2moves));
plot(Lx,Ly,'go--')
hold on
plot(Lx',Ly','b-')
