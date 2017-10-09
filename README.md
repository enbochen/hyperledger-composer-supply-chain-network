# Hyperledger Composer Supply Chain Network

This is one implementation of [Hyperledger Composer](https://github.com/hyperledger/composer) for supply chain, which demonstrates how Hyperledger blockchain improve transparency and traceability of industrial supply chain.

![](/docs/flow.png)


This business network defines:

**Participant**
`Manufacturer` `OEM` `Distributor`

**Asset**
`Commodity`

**Transaction**
`M2O` `O2D`

**Event**
`none` (WIP)

Commodity are owned by a Manufacturer,OEM or Distributor,  and the owner property on a Commodity can be modified by submitting a transaction(e.g. M2O, O2D). The transaction emits a SampleEvent that notifies applications of the old and new values for each modified Commodity.(WIP)

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


Congratulations!



More info:
- Build on [template](https://github.com/hyperledger/composer-sample-networks/tree/master/packages/basic-sample-network)
- Hyperledger Composer Official [Documentation](https://hyperledger.github.io/composer/introduction/introduction.html)
- Developer [Guide](https://hyperledger.github.io/composer/tutorials/developer-guide.html)
- In-depth research on hyperledger composer [link](https://github.com/aietcn/hyperledger-composer)
