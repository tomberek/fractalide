{ buildFractalideComponent, filterContracts, genName }:

buildFractalideComponent rec {
  name = genName ./.;
  src = ./.;
  contracts = filterContracts ["file"];
  depsSha256 = "0lyb4k6vcn3ckp99vh2crb4z8myj75rz1pjwcr05jvr6wsgalppm";
}
