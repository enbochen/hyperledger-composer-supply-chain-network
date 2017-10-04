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
        And I have added the following participants of type org.hcsc.network.Trader
            | tradeId         | firstName | lastName |
            | alice@email.com | Alice     | A        |
            | bob@email.com   | Bob       | B        |
        And I have added the following assets of type org.hcsc.network.Commodity
            | tradingSymbol | description | mainExchange | quantity | owner           |
            | 1             | One         | London       | 1          | alice@email.com |
            | 2             | Two         | Paris        | 2          | bob@email.com   |
        And I have issued the participant org.hcsc.network.Trader#alice@email.com with the identity alice1
        And I have issued the participant org.hcsc.network.Trader#bob@email.com with the identity bob1
    Scenario: Alice can read all of the assets
        When I use the identity alice1
        Then I should have the following assets of type org.hcsc.network.Commodity
            | tradingSymbol | description | mainExchange | quantity | owner           |
            | 1             | One         | London       | 1          | alice@email.com |
            | 2             | Two         | Paris        | 2          | bob@email.com   |
    Scenario: Bob can read all of the assets
        When I use the identity bob1
        Then I should have the following assets of type org.hcsc.network.Commodity
            | tradingSymbol | description | mainExchange | quantity | owner           |
            | 1             | One         | London       | 1          | alice@email.com |
            | 2             | Two         | Paris        | 2          | bob@email.com   |
    Scenario: Alice can add assets that she owns
        When I use the identity alice1
        And I add the following asset of type org.hcsc.network.Commodity
            | tradingSymbol | description | mainExchange | quantity | owner           |
            | 3             | Three       | New York     | 3          | alice@email.com |
        Then I should have the following assets of type org.hcsc.network.Commodity
            | tradingSymbol | description | mainExchange | quantity | owner           |
            | 3             | Three       | New York     | 3          | alice@email.com |
    Scenario: Bob can add assets that he owns
        When I use the identity bob1
        And I add the following asset of type org.hcsc.network.Commodity
            | tradingSymbol | description | mainExchange | quantity | owner           |
            | 4             | Four        | Rome         | 4          | bob@email.com   |
        Then I should have the following assets of type org.hcsc.network.Commodity
            | tradingSymbol | description | mainExchange | quantity | owner           |
            | 4             | Four        | Rome         | 4          | bob@email.com   |
    Scenario: Alice can update her assets
        When I use the identity alice1
        And I update the following asset of type org.hcsc.network.Commodity
            | tradingSymbol | description | mainExchange | quantity | owner           |
            | 1             | One         | London       | 5        | alice@email.com |
        Then I should have the following assets of type org.hcsc.network.Commodity
            | tradingSymbol | description | mainExchange | quantity | owner           |
            | 1             | One         | London       | 5        | alice@email.com |
    Scenario: Bob can update his assets
        When I use the identity bob1
        And I update the following asset of type org.hcsc.network.Commodity
            | tradingSymbol | description | mainExchange | quantity | owner           |
            | 2             | Two         | Paris        | 6        | bob@email.com   |
        Then I should have the following assets of type org.hcsc.network.Commodity
            | tradingSymbol | description | mainExchange | quantity | owner           |
            | 2             | Two         | Paris        | 6        | bob@email.com   |
    Scenario: Alice can remove her assets
        When I use the identity alice1
        And I remove the following asset of type org.hcsc.network.Commodity
            | tradingSymbol |
            | 1             |
        Then I should not have the following assets of type org.hcsc.network.Commodity
            | tradingSymbol |
            | 1             |
    Scenario: Bob can remove his assets
        When I use the identity bob1
        And I remove the following asset of type org.hcsc.network.Commodity
            | tradingSymbol |
            | 2             |
        Then I should not have the following assets of type org.hcsc.network.Commodity
            | tradingSymbol |
            | 2             |
    Scenario: Alice can submit a transaction for her assets
        When I use the identity alice1
        And I submit the following transaction of type org.hcsc.network.Trade
            | commodity | newOwner      |
            | 1         | bob@email.com |
        Then I should have the following assets of type org.hcsc.network.Commodity
            | tradingSymbol | description | mainExchange | quantity | owner           |
            | 1             | One         | London       | 1          | bob@email.com |
    Scenario: Bob can submit a transaction for his assets
        When I use the identity bob1
        And I submit the following transaction of type org.hcsc.network.Trade
            | commodity | newOwner        |
            | 2         | alice@email.com |
        Then I should have the following assets of type org.hcsc.network.Commodity
            | tradingSymbol | description | mainExchange | quantity   | owner           |
            | 2             | Two         | Paris        | 2          | alice@email.com   |
