# EmojiHub

EmojiHub is a sample assignment prepared in order to utilize the public APIs for EMOJIs and display a list of all. 
This also utilizes the random Emoji API to fetch and display the random emojis.
User can view list of emojis and also they can view their favorite emoji(through random API). 
The app also provides an option to re-render or refresh the favorite emoji by calling the random emoji API again.

Use cases:
- To display list of all Emojis and show details once selected.
- To display favorite emoji(by rendering random emoji from server) and provide an option to change if required.

APIs integrated(Public APIs):
- https://emojihub.herokuapp.com/api/all
- https://emojihub.herokuapp.com/api/random

Licenses and credit details:
- https://github.com/cheatsnake/emojihub

Architectural information:
- Mainly this application follows MVVM architecture.
- Different APIClient/ NetworkClient is written to handle all the network calls, with single responsibility to make the server call without checking the input/ output.
- Each module has different layes as per MVVM architecture.
- Two call-back or data binding techniques are used -- a. Call back by capturing "Closures" b. Observable pattern.
- Module level API service layer is also written in order to segregate the load and to introduce scope of test cases.
- Stub generator is also used to mock the success/ failure scenarios.
- Test cases are also written and executed.
- Module level API service layer test cases are done with actual API and expectations.
- ViewModel layer test cases are done with mock responses and STUB generation.
- Stub jsons or mock josns are part of Resources in order to perform test scenarios.

Still any doubts?
Reach out at:

pushpendra2789@gmail.com
