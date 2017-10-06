#
# Licensed under the Apache License, Version 2   (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2  
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
Feature: Sample
    Background:
        Given I have deployed the business network definition ..
        And I have added the following participants of type org.hcsc.network.Manufacturer
            | tradeId         | companyName |
            | M1              | FASTory     | 
        And I have added the following participants of type org.hcsc.network.OEM
            | tradeId         | companyName |
            | O1              | Red         | 
            | O2              | Blue        | 
            | O3              | Green       | 
        And I have added the following participants of type org.hcsc.network.Distributor
            | tradeId         | companyName |
            | D1              | East        | 
            | D2              | South       | 
            | D3              | North       | 
        And I have added the following assets of type org.hcsc.network.Commodity
            | tradingSymbol | description | mainExchange | quantity | owner         |
            | 1             | One         | London       | 1        | M1            |
            | 2             | Two         | Paris        | 2        | M1            |
        And I have issued the participant org.hcsc.network.Manufacturer#M1 with the identity m1
        And I have issued the participant org.hcsc.network.OEM#O1 with the identity o1
        And I have issued the participant org.hcsc.network.OEM#O2 with the identity o2
        And I have issued the participant org.hcsc.network.OEM#O3 with the identity o3
        And I have issued the participant org.hcsc.network.Distributor#D1 with the identity d1
        And I have issued the participant org.hcsc.network.Distributor#D2 with the identity d2
        And I have issued the participant org.hcsc.network.Distributor#D3 with the identity d3
    Scenario: FASTory can read all owned assets
        When I use the identity m1
        Then I should have the following assets of type org.hcsc.network.Commodity
            | tradingSymbol | description | mainExchange | quantity | owner           |
            | 1             | One         | London       | 1        | M1              |
            | 2             | Two         | Paris        | 2        | M1              |
    Scenario: FASTory can add its own assets
        When I use the identity m1
        And I add the following asset of type org.hcsc.network.Commodity
            | tradingSymbol | description | mainExchange | quantity | owner         |
            | 3             | Three       | New York     | 3        | M1            |
        Then I should have the following assets of type org.hcsc.network.Commodity
            | tradingSymbol | description | mainExchange | quantity | owner         |
            | 3             | Three       | New York     | 3        | M1            |
    Scenario: FASTory can submit a transaction to OEM by M2O method
        When I use the identity m1
        And I submit the following transaction of type org.hcsc.network.M2O
            | commodity | issuer      |newOwner      | 
            | 1         | M1          |O1            |
        When I use the identity o1
        Then I should have the following assets of type org.hcsc.network.Commodity
            | tradingSymbol | issuer   |description | mainExchange | quantity | owner        |
            | 1             | M1       |One         | London       | 1        | O1           |
    Scenario: O1 can submit a transaction to Distributor by O2D
        When I use the identity o1
        And I submit the following transaction of type org.hcsc.network.O2D
            | commodity | issuer          |newOwner      |
            | 2         | O1              |D1            |
        When I use the identity d1
        Then I should have the following assets of type org.hcsc.network.Commodity
            | tradingSymbol | description | mainExchange | quantity   | owner           |
            | 2             | Two         | Paris        | 2          | D1              |
