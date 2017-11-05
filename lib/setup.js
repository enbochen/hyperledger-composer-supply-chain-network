/*
* Licensed under the Apache License, Version 2.0 (the "License");
* you may not use this file except in compliance with the License.
* You may obtain a copy of the License at
*
* http://www.apache.org/licenses/LICENSE-2.0
*
* Unless required by applicable law or agreed to in writing, software
* distributed under the License is distributed on an "AS IS" BASIS,
* WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
* See the License for the specific language governing permissions and
* limitations under the License.
*/

/**
* Setup the demo
* @param {org.hcsc.network.SetupDemo} setupDemo - the SetupDemo transaction
* @transaction
*/
function setupDemo(setupDemo) {
    console.log('setupDemo');
    
    var factory = getFactory();
    var NS = 'org.hcsc.network';
    
    var manufacturers = [
        factory.newResource(NS, 'Manufacturer', 'M1'),
        factory.newResource(NS, 'Manufacturer', 'M2'),
        factory.newResource(NS, 'Manufacturer', 'M3'),
    ];
    return getParticipantRegistry(NS + '.Manufacturer')
        .then(function (manufacturerRegistry){
          manufacturers.forEach(function(manufacturer){
            manufacturer.companyName = 'MMM'
          });
          return manufacturerRegistry.addAll(manufacturers);
        });
} 