# Git Agreement

1. Always create a new branch from `development` branch to execute coding a new feature
2. Commit early and always commit before leaving your code
3. When done with your feature, make sure your code have been updated from `development` using
    
    ```bash
    git pull origin development
    ```
    
4. after updating your branch with the `development` it may have some conflict. Solve the conflict on your branch first and then create pull request
5. Always create PULL REQUEST to make your branch merged with the `development` branch
6. Assign @Muhammad Rasyad Caesarardhi (mrasyadc) Muhammad Rasyad Caesarardhi as Reviewers
7. only @Muhammad Rasyad Caesarardhi can accept a Pull Request

# Code Guidelines

- 🏃‍♀️**Optimizing ⭐️**
    - Use breakpoint to do debugging
    - Using instruments to solve issues and optimize general performance
    - Implement Multithreading for complex async process
    - Using unit testing and UI testing
- 🚦 **Consistency →** Make your code consistent in order to easier debugging
    - DRY → Don't repeat yourself → try to find code/component thats repeatable and make it reusable
    - Have clear pattern of the code flow and consistent across features
    - Try to check for its general performance
    - If their app consists storing data in cloud, check for whether the data is needed
    - Maximize the Swift capabilities such as the use of enum, pre-built function(Sort,filter) in sequence type like array, property observers
- 👓 **Readability →** More readable code = Happy Developers = Faster development ❤️
    - Clean all the warnings !!
    - Clean all the comments in code !!
    - Avoid Nesting your code, it can be a headache
        - Nested Loop
            - Can use Higher-order function, for example in array use `sort()`, `filter()`, `reduce()`
        - Avoid nested if !! consider
            - Separate into function
            - use early exit such as guard
            - consider using switch
            - For more advanced solutions, use the combined framework
        
        ```swift
        {
        	Code
        	{
        		Nested Code 1
        		{
        			Nested code 2
        			{
        				Nested code 3
        				{
        					Nested code 4
        				}
        			}
        		}
        	}
        }
        
        ```
        
    - Take more time when writing code to optimize for reading. Code is read much more often than written. Consider:
        - Clear naming convention
        - Clear folder naming and structure
        - Clear code architecture and design pattern
        - Define the access controls of each method and properties → `public` / `private` / `filePrivate` / `internal` → this will help developers to know which part of the class that is used by other class or just the internal class **⭐️**
        - Avoid using plain string for any kind of conditional, instead, try to use an `enum` for more safety purposes and readability
        - Avoid using global variables/functions, wrap it into some `class` or `struct` for better readability
        - Using reusable function and view (modularity)
        - Using SwiftLint as recommended tools for code style
- 🛠 **Maintainability →** Easier to add more features in the future and safer
    - KISS (KEEP IT SIMPLE AND STUPID) / Single Responsibility for each file → Encourage learners to create each swift with single responsibility. Example in MVC:
        - **Controller** file should only connect all the logic from the utilities, view, and model file
        - View file should only know how to use the data given from the model into the interface
        - Create separate features that only performs specific task into new class or extension for example for networking manager, core data manager etc
    - NO "!" IN ANY OF YOUR CODE
        - No force unwrap →`myOptionalVar!`
        - No force typecast → `as!`
        - No force try → `try!`
    - UI wise
        - For most cases, Avoid using constant such as for spacing, padding, etc. consider using percentage of screen
        - App navigation, i.e using unwind segues instead of push
    - If you are using 3rd party framework
        - is there some kind of abstraction to it
        - If you dont use any package management such as SPM / Cocoapods make sure to separate its folder. But recommended to use package management

## **Sources**

[GITRA Code Review Documentation.pages](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/37fb4765-3119-4cc5-bbaf-20dbe986941b/GITRA_Code_Review_Documentation.pages)

- Source for the guidelines → https://github.com/FadiOssama/Swift-Code-Review-Checklist/blob/master/CHECKLIST.md
- Source for the guidelines → https://medium.com/@same7mabrouk/the-checklist-of-my-code-review-18cc6f6fb5b3
- Sources for the code review structure and process → https://github.com/DevMountain/ios-code-review-checklist
- Some insight → https://thoughtbot.com/blog/ios-code-review-guidlines
- Beneficial tool for better code review → https://medium.com/@andr3a88/improve-your-code-reviews-using-danger-swift-on-bitrise-ci-e05c90a03244
- Reference for app performance (more advanced) : https://docs.google.com/document/d/1nbXp0wgplVuZfx4gd9DnI-tyh8Shu3INE0s3X06AkTI/edit
- Swift style guide → https://github.com/github/swift-style-guide
