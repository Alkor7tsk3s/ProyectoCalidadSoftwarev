module owlchain.api.api;

interface IOntology {

}

interface IOwlReasoner {
	bool loadData(ubyte[] owlData);
	bool loadFile(string owlPath);
}

interface ITalInterpreter {
		
}

interface ITransaction {
	string getHash();
	int getVer();
	int getVinSize();
	int getvoutSize();
	string getLockTime();
	int getSize();
	int getBlockHeight();
	int getTxIndex();
}

interface IBlock {
    string getHash();
    int getVer();
    string getPrevBlock();
    string getMrklRoot();
    string getTime();
    int getBits();
    int getNTx();
    int getSize();
    int getBlockIndex();
    bool getMainChain();
    int getHeight();
    string getReceivedTime();
    ITransaction[] getTransactions();
}

interface IBlockchain {
	enum BlockchainState {
        BS_Ready = 0,
        BS_Syncing,
        BS_Offline
    }
    int getLastBlockIndex();
	int getLastBlockHeight();
	IBlock getLastBlock();
	IBlock getBlock(int index);
	IBlock getBlock(string hash);
    bool isReady();
    BlockchainState getState();
    ITransaction[] getTransactions(IAddress address);
    ITransaction[] getTransactions(IAccount acount);
}

interface IWallet {
    IAccount getAccount();
    string createSeed();
    bool removeAccount(IAddress address);
    bool removeAccount(IAccount account);
}

enum MaxAliasSize = 100;
alias ubyte[MaxAliasSize] AccountAlias;

interface IAccount {
    string getAddress();
    string getAlias();
    void setAlias(AccountAlias aliasName);
    ulong getBalance();
    bool send(ulong amount, IAccount receiver);
    bool send(ulong amount, IAddress address);
    bool setFreeze(ulong amount);
}

interface IAddress {
    bool isValid();
    string toString();
}

interface IOCCPRequest {

}

interface IOCCPResponse {

}

interface IOCCPListener {

}

interface IOCCPSettings {

}

alias OCCPRequestDeligate = void delegate(IOCCPRequest req, IOCCPResponse res);

interface IShell {
    IWallet getWallet();
    IBlockchain getBlockchain();
    IOCCPListener listenOCCP(IOCCPSettings settings, OCCPRequestDeligate requestHandler);
}

interface IOperator {
    ITransaction execute(scope IOntology ontology, scope IBlockchain blockchain) pure;  
}

