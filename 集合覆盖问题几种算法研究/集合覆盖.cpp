// ���ϸ���.cpp : �������̨Ӧ�ó������ڵ㡣
#include <iostream>
#include <ctime>
#include <set>
#include<algorithm>
#include<vector>
#include<queue>
using namespace std;

typedef struct {
	int *path;     // ����ڵ�·����  1��ʾ��·���� 0��ʾ����·���� 
	int i;	       // ��ǰ����� 
	int numSet;    // ��ǰ������ 
} branchNode;

// �������� ���㵱ǰ�ڵ�ļ����Ƿ��Ѿ���������U
bool branchNodeJudgeSet(const set<int> &U,const vector<set<int> > &S,const branchNode &node) 
{
	set<int> temp;
	set<int>::iterator it1; // ���������� 
	for(int j=0;j<node.i;++j)
		if(node.path[j]==1)
		{
			it1=S[j].begin();
			while(it1!=S[j].end())
				temp.insert(*it1++);				
		}
	if(temp.size()<U.size()) return false;  // û����ȫ���� 
	else return true;  //�Ѿ���ȫ���� 
}

// ��֧�޽���⼯�ϸ�������
clock_t branchForSCP(const set<int> &U,vector<set<int> > &S,branchNode &minNode) 
{
	clock_t start=clock();    //��ʼʱ��
	
	queue<branchNode> Q;    //�����ڵ�Ķ���	
	branchNode nullNode;nullNode.path=NULL;  // ��ʶÿ��Ľ���λ�� 
	Q.push(nullNode); // ���  ��һ����� 
	
	//���Žڵ��ʼ�� 
	minNode.numSet=0;
	minNode.i=0;
	minNode.path=new int[S.size()];
	minNode.numSet=0;
	
	// ��ǰ�ڵ� 
	branchNode currentNode;
	currentNode.i=0;
	currentNode.path=new int[S.size()];
	currentNode.numSet=0;
	
	// ��ʼ��֧�޽��� 
	while(true)
	{
		if(currentNode.i==S.size()) break;  // ����������һ�� ���˳� 
		// ����ӽڵ�	
		branchNode leftNode;  
		leftNode.i=currentNode.i+1;
		leftNode.path=new int[S.size()];
		copy(currentNode.path,currentNode.path+currentNode.i,leftNode.path);
		leftNode.path[currentNode.i]=1;  // ����Ӿ���1 ѡ��ǰ����i
		leftNode.numSet= currentNode.numSet+1;   // ���¼�����Ŀ
		
		if(branchNodeJudgeSet(U,S,leftNode)) // ����Ѿ�����  
		{
			//cout<<"�󸲸�\n";
			if(minNode.numSet==0||minNode.numSet>leftNode.numSet) // ��������Ž��� �洢 
			{
				minNode.numSet=leftNode.numSet;
				minNode.i=leftNode.i;
				copy(leftNode.path,leftNode.path+leftNode.i,minNode.path); 
				// ���ü������� ��Ϊ�Ѿ��ҵ��� �������ȥҲ�����Ǹ��ŵĽ� 
			}
				
		}else if(leftNode.numSet<minNode.numSet||minNode.numSet==0) // ������ ��� �������� 
			Q.push(leftNode);   // ���

		// �Ҷ��ӽ��
		branchNode rightNode;  
		rightNode.i=currentNode.i+1;
		rightNode.path=new int[S.size()];
		copy(currentNode.path,currentNode.path+currentNode.i,rightNode.path);
		rightNode.path[currentNode.i]=0;        // ����Ӿ���1 ѡ��ǰ����i
		rightNode.numSet= currentNode.numSet;   // ���¼�����Ŀ
		Q.push(rightNode);   // ��� 
		
		currentNode=Q.front();Q.pop();  // ����
		if(currentNode.path==NULL)      // ����ͬ�ǽڵ�Ľ�β
		{
			if(!Q.empty())  // �ǿ� 
			{
				Q.push(nullNode);  // ���ͬ��ڵ�Ľ�β
				currentNode=Q.front();Q.pop();  // ���� 
			}	
		} 
	} 
	
	clock_t end=clock();      // ����ʱ�� 
    return end-start;
}

// ���ݷ���⼯�ϸ�������
void backtrack(vector<set<int> > &S,vector<set<int> > &minC,const set<int> &U,int k) 
{
	// �����жϵ�ǰ��0-k�Ƿ���һ�����н�
	set<int> temp;
	vector<set<int> >::iterator it1;  // �����õ� 
	set<int>::iterator it2;  // �����õ� 
	//���쵱ǰ����Ӽ���ļ��ϡ� 
	it1=S.begin();
	while(it1!=S.begin()+k)  
	{
		it2=it1->begin();
		while(it2!=it1->end())
			temp.insert(*it2++);
		++it1;
	}
	// �ж��Ƿ��ǿ��н� ����ǿ��н� �ͱ��� 
	if(temp.size()>=U.size())
	{
		minC.clear();
		it1=S.begin();
		while(it1!=S.begin()+k) 
			minC.push_back(*it1++); 	
	} else  // ���ǿ��н� �ͼ������ݲ��� 
	{
		for(int i=k+1;i<S.size();++i)  // ��һ��
		{
			// ��֦ 
			if(k+1<minC.size()||minC.size()==0)
			{
				swap(S[k],S[i]);
			 	 backtrack(S,minC,U,k+1);  // ������һ��
				 swap(S[k],S[i]);
			}	 
		} 
	} 
}

// ���ݷ���⼯�ϸ�������
clock_t backtrackForSCP(vector<set<int> > &S,vector<set<int> > &minC,const set<int> &U)
{
	minC.clear(); 
	clock_t start=clock();    // ��ʼʱ��
	backtrack(S,minC,U,0);
	clock_t end=clock();      // ����ʱ�� 
    return end-start;
}


// ̰���㷨��⼯�ϸ�������   ��������ʱ��  �� minC 
clock_t greeyForSCP(const set<int> &U,vector<set<int> > &S,vector<set<int> > &minC) 
{
	minC.clear(); 
	clock_t start=clock();    //��ʼʱ��
	 
	set<int> C,temp,cMax;
	vector<set<int> >::iterator itmax;  // ��¼�����Ǹ�λ�� 
	vector<set<int> >::iterator it1;    // �����õ� 
	set<int>::iterator it2;          // �����õ� 
	while(C.size()<U.size())         // ����������0 ��֤��û���ҵ���С���� 
	{
		cMax.clear(); // �����ÿ� 
		// ��ʼ̰���㷨  ̰���㷨���� ��ʣ���Ӽ����ҵ�һ�������뵱ǰC���������ļ���
		it1=S.begin();
		while(it1!=S.end())  // �����Ӽ���  ̰�Ĳ��������Ǹ��Ӽ� 
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
		// �����ļ�¼�����������Լ��� C minC
		set<int> mm;
		it2=itmax->begin(); 
		while(it2!=itmax->end())  // ������С�� 
		{
			mm.insert(*it2);
			C.insert(*it2);
			++it2;
		}
		minC.push_back(mm);   // ������С���� 
		S.erase(itmax);   // �Ӽ��� ɾ�� 
	}
	
	clock_t end=clock();      // ����ʱ�� 
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
	vector<set<int> >::iterator it1;  // �����õ� 
	set<int>::iterator it2;  // �����õ� 
	
	//���޼�U,����10��Ԫ��
	int u[12]={1,2,3,4,5,6,7,8,9,10,11,12};
	set<int> U(u,u+12);
	//�Ӽ���F
	int a[6]={1,2,5,6,9,10};set<int> A(a,a+6);
	int b[4]={6,7,10,11};set<int> B(b,b+4);
	int c[4]={1,2,3,4};set<int> C(c,c+4);
	int d[5]={3,5,6,7,8};set<int> D(d,d+5);
	int e[4]={9,10,11,12};set<int> E(e,e+4);
	int f[2]={4,8};set<int> F(f,f+2);
	
	vector<set<int> > S;  // �Ӽ���
	S.push_back(A);	S.push_back(B);	S.push_back(C);	S.push_back(D);	S.push_back(E);	S.push_back(F);
	
	// ������⼯�� 
	it2=U.begin();
	cout<<"�ܼ���:\n{";
	while(it2!=U.end())
		cout<<*it2++<<" ";
	cout<<"}"<<endl;
	it1=S.begin();
	cout<<"�Ӽ���:\n";
	while(it1!=S.end())
	{
		cout<<"{";
		it2=it1->begin();
		while(it2!=it1->end())
			cout<<*it2++<<" ";
		cout<<"}"<<endl;
		++it1;
	}
	
	
	// ��֧�޽��㷨
	branchNode minNode; 
	cout<<"\n\n��֧�޽��㷨...\n����ʱ��:"<<branchForSCP(U,S,minNode)<<"ms";  // ���з�֧�޽��㷨 
	cout<<"\n��С���Ǽ�:\n";
	for(int i=0;i<minNode.i;++i)
		if(minNode.path[i]==1)
			printSet(S[i]);
	
		
	vector<set<int> > minC;  //��С���� 
	
	cout<<"\n\n�����㷨...\n����ʱ��:"<<backtrackForSCP(S,minC,U)<<"ms";  // ����̰���㷨 
	cout<<"\n��С���Ǽ�:\n";
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
	
	cout<<"\n\n̰���㷨...\n����ʱ��:"<<greeyForSCP(U,S,minC)<<"ms";  // ����̰���㷨 
	cout<<"\n��С���Ǽ�:\n";
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


