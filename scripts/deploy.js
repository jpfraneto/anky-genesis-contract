async function main() {
  const AnkyTest6 = await ethers.getContractFactory('AnkyTest6');

  // Start deployment, returning a promise that resolves to a contract object
  const ankyTester = await AnkyTest6.deploy();
  console.log('Contract deployed to address:', ankyTester.address);
}

main()
  .then(() => process.exit(0))
  .catch(error => {
    console.error(error);
    process.exit(1);
  });
