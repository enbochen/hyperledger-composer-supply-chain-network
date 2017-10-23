# Hyperledger Composer Supply Chain Network

This is one implementation of [Hyperledger Composer](https://github.com/hyperledger/composer) for supply chain, which demonstrates how Hyperledger blockchain improve transparency and traceability of industrial supply chain.

![](/docs/flow.png)

### How to run it?

1. Install packages: `npm install`
2. Create a folder for local archive: `mkdir dist`
3. Generate the BNA(Business Network Archieve) file: `composer archive create -a dist/hyperledger-supply-chain-network.bna --sourceType dir --sourceName . ` (Note: the command `npm run prepublish` achieves the same thing)
4. Next, in a browser, navigate to the online Bluemix Composer Playground http://composer-playground.mybluemix.net and import the newly-generated BNA file into the Playground using the "Import/Replace" button at the bottom left of the screen. Locate the `dist/hyperledger-supply-chain-network.bna` file under your 'hyperledger-supply-chain-network' folder and upload it. This automatically deploys the new business network. 
5. Try to play with it. ([Playground Tutorial](https://hyperledger.github.io/composer/tutorials/playground-guide.html))

Congratulations!

P.S. No.4 just only runs on web brower, all the data are stored in local storage. If you want run it on real blockchain network. Please follow [Developer Guide](https://hyperledger.github.io/composer/tutorials/developer-guide.html) and [Developer Environment](https://hyperledger.github.io/composer/installing/development-tools.html) to make it real!


### Model
This business network defines:

- **Participant**
`Manufacturer` `OEM` `Distributor`

- **Asset**
`Commodity`

- **Transaction**
`M2O` `O2D`

- **Event**
`none` (WIP)

Commodity are owned by a Manufacturer,OEM or Distributor,  and the owner property on a Commodity can be modified by submitting a transaction(e.g. M2O, O2D). The transaction emits a SampleEvent that notifies applications of the old and new values for each modified Commodity.(WIP)

### How to play on Bluemix Composer Playground?

To test this Business Network Definition in the **Test** tab:

Create a `Manufacturer` participant:

```
{
  "$class": "org.hcsc.network.Manufacturer",
  "tradeId": "M1",
  "companyName": "FAST"
}
```

Create a `Commodity` asset:

```
{
  "$class": "org.hcsc.network.Commodity",
  "tradingSymbol": "ts1",
  "description": "Aliquip.",
  "mainExchange": "Commodo.",
  "quantity": 216.3,
  "owner": "resource:org.hcsc.network.Manufacturer#M1"
}
```

Submit a `M2O` transaction:

```
{
  "$class": "org.hcsc.network.M2O",
  "commodity": "resource:org.hcsc.network.Commodity#ts1",
  "issuer": "resource:org.hcsc.network.Manufacturer#M1",
  "newOwner": "resource:org.hcsc.network.OEM#O1"
}
```

After submitting this transaction, you should now see the transaction in the Transaction Registry and that a `SampleEvent` has been emitted(WIP). As a result, the value of the `tradingSymbol:ts1` should now be `new owner` in the Asset Registry.

### Pre-requisites on MacOS
- [Install nvm and Apple Xcode](https://hyperledger.github.io/composer/installing/prereqs-mac.html)
- [Installing Hyperledger Composer development tools](https://hyperledger.github.io/composer/installing/development-tools.html) (Most important: `npm install -g composer-cli`)

### More info:
- Build on [template](https://github.com/hyperledger/composer-sample-networks/tree/master/packages/basic-sample-network)
- Hyperledger Composer Official [Documentation](https://hyperledger.github.io/composer/introduction/introduction.html)
- Developer [Guide](https://hyperledger.github.io/composer/tutorials/developer-guide.html)
- In-depth research on hyperledger composer [link](https://github.com/aietcn/hyperledger-composer)
