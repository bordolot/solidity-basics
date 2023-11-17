// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";

interface IProfile {
    struct UserProfile {
        string displayName;
        string bio;
    }
    function getProfile (address _user) external view returns (UserProfile memory);
}

contract Twitter is Ownable(msg.sender) {

    uint16 public MAX_TWEET_LENGTH = 30;

    struct Tweet{
        uint256 id;
        address author;
        string content;
        uint256 timestamp;
        uint256 likes;
    }

    mapping(address => Tweet []) public tweets;
    // profile contract defined here
    IProfile profileContract;

    event TweetCreated(uint256 id, address author, string content, uint256 timestamp);
    event TweetLiked(address liker, address tweetAuthor, uint256 tweetId, uint256 newLikeCount);
    event TweetUnliked(address unliker, address tweetAuthor, uint256 tweetId, uint256 newLikeCount);

    modifier onlyRegistered() {
        IProfile.UserProfile memory userProfileTemp = profileContract.getProfile(msg.sender);
        require(bytes(userProfileTemp.displayName).length > 0, "USER NOT REGISTERED");
        _;
    }  

    constructor(address _profileContract){
        profileContract = IProfile(_profileContract); 
    }

    function changeTweetLength(uint16 newTweetLength) public onlyOwner {
        MAX_TWEET_LENGTH = newTweetLength;
    }

    function getTotalLikes(address _author) external view returns(uint){
        uint totalLikes;
        for(uint i = 0; i < tweets[_author].length;i++){
            totalLikes += tweets[_author][i].likes;
        } 
        return totalLikes;
    }

    function createTweet(string memory _tweet) public onlyRegistered {
        require(bytes(_tweet).length <= MAX_TWEET_LENGTH, "Tweet is too long!");
        Tweet memory newTweet = Tweet({
            id:tweets[msg.sender].length,
            author: msg.sender,
            content: _tweet,
            timestamp: block.timestamp,
            likes: 0
        });

        tweets[msg.sender].push(newTweet);

        emit TweetCreated(newTweet.id, newTweet.author, newTweet.content, newTweet.timestamp);
    }

    function likeTweets(address author, uint id) external onlyRegistered {
        require(tweets[author][id].id == id, "TWEET DOES NOT EXIST");
        tweets[author][id].likes++;

        emit TweetLiked(msg.sender, author, id, tweets[author][id].likes);
    }

    function unlikeTweet(address author, uint256 id) external onlyRegistered {
        require(tweets[author][id].id == id, "TWEET DOES NOT EXISTS");
        require(tweets[author][id].likes > 0, "TWEET HAS NO LIKES");
        tweets[author][id].likes--;

        emit TweetUnliked(msg.sender, author, id, tweets[author][id].likes);
    }

    function getTweet (address _owner, uint _i) public view returns (Tweet memory){
        return tweets[_owner][_i];
    }

    function getAllTweets(address _owner) public view returns (Tweet[] memory){
        return tweets[_owner];
    }

}