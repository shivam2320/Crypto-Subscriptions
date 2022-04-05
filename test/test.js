const { ethers } = require('hardhat');
const { expect } = require('chai');

describe("Stream Testing", () => {

    let owner;
    let addr1;
    let CryptoStream;
    let cryptoStream;
    let TestToken;
    let testToken;

    beforeEach(async () => {
        [owner, addr1] = await ethers.getSigners();

        CryptoStream = await ethers.getContractFactory("CryptoStream");
        cryptoStream = await CryptoStream.deploy();
        await cryptoStream.deployed();

        TestToken = await ethers.getContractFactory("TestERC20");
        testToken = await TestToken.deploy();
        await testToken.deployed();
        
    });

    
    // console.log("CryptoStream Address: ", cryptoStream.address);

    // console.log("TestToken Address: ", testToken.address);

    console.log("timestamp: ", block.timestamp);

    // describe("CreateStream", () => {
    //     it("Should deposit", async () => {
    //        await testToken.mint(owner.address, 10000000);
    //        await testToken.approve(cryptoStream.address, 100000000); 

    //        await cryptoStream.createStream(addr1.address, 100000, testToken.address, )
    //        expect(await cryptoStream.totalSupply()).to.equal(2);
    //        expect(await cryptoStream.ownerOf(23)).to.equal(owner.address);

    //        console.log("TokenURI: ",await cryptoStream.tokenURI(23));
    //     });
    // });

    // describe("Transfers", () => {
    //     it("Transfer properly", async () => {
    //         await cricVerse.claim(23, {value: ethers.utils.parseEther("1")});
    //         await cricVerse.transferFrom(owner.address, addr1.address, 23);
    //         expect(await cricVerse.balanceOf(addr1.address)).to.equal(1);
    //     });
    // });

    // describe("Withdraw", () => {
    //     it("Should withdraw balance", async () => {
    //         await cricVerse.connect(addr1).claim(23, {value: ethers.utils.parseEther("90")});
    //         console.log(this.address.balance);
    //     });
    // });

});