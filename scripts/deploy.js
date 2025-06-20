const hre = require("hardhat");

async function main() {
  const ResumeVerification = await hre.ethers.getContractFactory("ResumeVerification");
  const resumeVerification = await ResumeVerification.deploy();
  await resumeVerification.deployed();
  console.log("ResumeVerification deployed to:", resumeVerification.address);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
