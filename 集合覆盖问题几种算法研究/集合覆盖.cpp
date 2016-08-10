// 集合覆盖.cpp : 定义控制台应用程序的入口点。
#include <iostream>
#include <ctime>
#include <set>
#include<algorithm>
#include<vector>
#include<queue>
using namespace std;

typedef struct {
	int *path;     // 保存节点路径的  1表示在路径上 0表示不再路径上 
	int i;	       // 当前顶点层 
	int numSet;    // 当前集合数 
} branchNode;

// 辅助函数 计算当前节点的集合是否已经覆盖主集U
bool branchNodeJudgeSet(const set<int> &U,const vector<set<int> > &S,const branchNode &node) 
{
	set<int> temp;
	set<int>::iterator it1; // 遍历迭代器 
	for(int j=0;j<node.i;++j)
		if(node.path[j]==1)
		{
			it1=S[j].begin();
			while(it1!=S[j].end())
				temp.insert(*it1++);				
		}
	if(temp.size()<U.size()) return false;  // 没有完全覆盖 
	else return true;  //已经完全覆盖 
}

// 分支限界求解集合覆盖问题
clock_t branchForSCP(const set<int> &U,vector<set<int> > &S,branchNode &minNode) 
{
	clock_t start=clock();    //开始时钟
	
	queue<branchNode> Q;    //保存活节点的队列	
	branchNode nullNode;nullNode.path=NULL;  // 标识每层的结束位置 
	Q.push(nullNode); // 入队  第一层入队 
	
	//最优节点初始化 
	minNode.numSet=0;
	minNode.i=0;
	minNode.path=new int[S.size()];
	minNode.numSet=0;
	
	// 当前节点 
	branchNode currentNode;
	currentNode.i=0;
	currentNode.path=new int[S.size()];
	currentNode.numSet=0;
	
	// 开始分支限界了 
	while(true)
	{
		if(currentNode.i==S.size()) break;  // 如果到达最后一层 则退出 
		// 左儿子节点	
		branchNode leftNode;  
		leftNode.i=currentNode.i+1;
		leftNode.path=new int[S.size()];
		copy(currentNode.path,currentNode.path+currentNode.i,leftNode.path);
		leftNode.path[currentNode.i]=1;  // 左儿子就是1 选择当前集合i
		leftNode.numSet= currentNode.numSet+1;   // 更新集合数目
		
		if(branchNodeJudgeSet(U,S,leftNode)) // 如果已经覆盖  
		{
			//cout<<"左覆盖\n";
			if(minNode.numSet==0||minNode.numSet>leftNode.numSet) // 如果是最优解则 存储 
			{
				minNode.numSet=leftNode.numSet;
				minNode.i=leftNode.i;
				copy(leftNode.path,leftNode.path+leftNode.i,minNode.path); 
				// 不用继续找了 因为已经找到了 左儿子下去也不会是更优的解 
			}
				
		}else if(leftNode.numSet<minNode.numSet||minNode.numSet==0) // 不覆盖 入队 继续搜索 
			Q.push(leftNode);   // 入队

		// 右儿子结点
		branchNode rightNode;  
		rightNode.i=currentNode.i+1;
		rightNode.path=new int[S.size()];
		copy(currentNode.path,currentNode.path+currentNode.i,rightNode.path);
		rightNode.path[currentNode.i]=0;        // 左儿子就是1 选择当前集合i
		rightNode.numSet= currentNode.numSet;   // 更新集合数目
		Q.push(rightNode);   // 入队 
		
		currentNode=Q.front();Q.pop();  // 出队
		if(currentNode.path==NULL)      // 到了同城节点的结尾
		{
			if(!Q.empty())  // 非空 
			{
				Q.push(nullNode);  // 添加同层节点的结尾
				currentNode=Q.front();Q.pop();  // 出队 
			}	
		} 
	} 
	
	clock_t end=clock();      // 结束时间 
    return end-start;
}

// 回溯法求解集合覆盖问题
void backtrack(vector<set<int> > &S,vector<set<int> > &minC,const set<int> &U,int k) 
{
	// 首先判断当前层0-k是否是一个可行解
	set<int> temp;
	vector<set<int> >::iterator it1;  // 遍历用的 
	set<int>::iterator it2;  // 遍历用的 
	//构造当前层的子集族的集合　 
	it1=S.begin();
	while(it1!=S.begin()+k)  
	{
		it2=it1->begin();
		while(it2!=it1->end())
			temp.insert(*it2++);
		++it1;
	}
	// 判断是否是可行解 如果是可行解 就保存 
	if(temp.size()>=U.size())
	{
		minC.clear();
		it1=S.begin();
		while(it1!=S.begin()+k) 
			minC.push_back(*it1++); 	
	} else  // 不是可行解 就继续回溯查找 
	{
		for(int i=k+1;i<S.size();++i)  // 下一层
		{
			// 剪枝 
			if(k+1<minC.size()||minC.size()==0)
			{
				swap(S[k],S[i]);
			 	 backtrack(S,minC,U,k+1);  // 搜索下一层
				 swap(S[k],S[i]);
			}	 
		} 
	} 
}

// 回溯法求解集合覆盖问题
clock_t backtrackForSCP(vector<set<int> > &S,vector<set<int> > &minC,const set<int> &U)
{
	minC.clear(); 
	clock_t start=clock();    // 开始时钟
	backtrack(S,minC,U,0);
	clock_t end=clock();      // 结束时间 
    return end-start;
}


// 贪婪算法求解集合覆盖问题   返回运行时间  和 minC 
clock_t greeyForSCP(const set<int> &U,vector<set<int> > &S,vector<set<int> > &minC) 
{
	minC.clear(); 
	clock_t start=clock();    //开始时钟
	 
	set<int> C,temp,cMax;
	vector<set<int> >::iterator itmax;  // 记录最大的那个位置 
	vector<set<int> >::iterator it1;    // 遍历用的 
	set<int>::iterator it2;          // 遍历用的 
	while(C.size()<U.size())         // 如果差集还大于0 就证明没有找到最小覆盖 
	{
		cMax.clear(); // 最大的置空 
		// 开始贪心算法  贪心算法就是 在剩余子集族找到一个最大的与当前C求解可以最大的集合
		it1=S.begin();
		while(it1!=S.end())  // 遍历子集族  贪心查找最大的那个子集 
		{
			temp=C;
			it2=it1->begin(); 
			while(it2!=it1->end())
				temp.insert(*it2++);
			if(temp.size()>cMax.size())
			{
				cMax=temp;
				itmax=it1;
			}
			++it1;	
		} 
		// 将最大的记录到现在最大的自己中 C minC
		set<int> mm;
		it2=itmax->begin(); 
		while(it2!=itmax->end())  // 更新最小集 
		{
			mm.insert(*it2);
			C.insert(*it2);
			++it2;
		}
		minC.push_back(mm);   // 插入最小集中 
		S.erase(itmax);   // 子集族 删除 
	}
	
	clock_t end=clock();      // 结束时间 
    return end-start;
}

void printSet(set<int> s)
{
	set<int>::iterator it=s.begin();
	cout<<"{";
	while(it!=s.end())
		cout<<*it++<<" ";
	cout<<"}"<<endl;
} 

int main()
{
	vector<set<int> >::iterator it1;  // 遍历用的 
	set<int>::iterator it2;  // 遍历用的 
	
	//有限集U,包含10个元素
	int u[12]={1,2,3,4,5,6,7,8,9,10,11,12};
	set<int> U(u,u+12);
	//子集族F
	int a[6]={1,2,5,6,9,10};set<int> A(a,a+6);
	int b[4]={6,7,10,11};set<int> B(b,b+4);
	int c[4]={1,2,3,4};set<int> C(c,c+4);
	int d[5]={3,5,6,7,8};set<int> D(d,d+5);
	int e[4]={9,10,11,12};set<int> E(e,e+4);
	int f[2]={4,8};set<int> F(f,f+2);
	
	vector<set<int> > S;  // 子集族
	S.push_back(A);	S.push_back(B);	S.push_back(C);	S.push_back(D);	S.push_back(E);	S.push_back(F);
	
	// 输出问题集合 
	it2=U.begin();
	cout<<"总集合:\n{";
	while(it2!=U.end())
		cout<<*it2++<<" ";
	cout<<"}"<<endl;
	it1=S.begin();
	cout<<"子集族:\n";
	while(it1!=S.end())
	{
		cout<<"{";
		it2=it1->begin();
		while(it2!=it1->end())
			cout<<*it2++<<" ";
		cout<<"}"<<endl;
		++it1;
	}
	
	
	// 分支限界算法
	branchNode minNode; 
	cout<<"\n\n分支限界算法...\n运行时间:"<<branchForSCP(U,S,minNode)<<"ms";  // 运行分支限界算法 
	cout<<"\n最小覆盖集:\n";
	for(int i=0;i<minNode.i;++i)
		if(minNode.path[i]==1)
			printSet(S[i]);
	
		
	vector<set<int> > minC;  //最小集合 
	
	cout<<"\n\n回溯算法...\n运行时间:"<<backtrackForSCP(S,minC,U)<<"ms";  // 运行贪婪算法 
	cout<<"\n最小覆盖集:\n";
	it1=minC.begin();
	while(it1!=minC.end())
	{
		cout<<"{";
		it2=it1->begin();
		while(it2!=it1->end())
			cout<<*it2++<<" ";
		cout<<"}"<<endl;
		++it1;
	}
	
	cout<<"\n\n贪心算法...\n运行时间:"<<greeyForSCP(U,S,minC)<<"ms";  // 运行贪婪算法 
	cout<<"\n最小覆盖集:\n";
	it1=minC.begin();
	while(it1!=minC.end())
	{
		cout<<"{";
		it2=it1->begin();
		while(it2!=it1->end())
			cout<<*it2++<<" ";
		cout<<"}"<<endl;
		++it1;
	}
	return 0;
}


