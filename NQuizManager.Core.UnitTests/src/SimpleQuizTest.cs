// <copyright file="SimpleQuizTest.cs" company="PlaceholderCompany">
// Copyright (c) PlaceholderCompany. All rights reserved.
// </copyright>

using NQuizManager.Core;

namespace NQuizManager.Core.UnitTests;

public class SimpleQuizTest
{
    private const int Number1 = 100;
    private const int Number2 = 200;

    [Fact]
    public void RightAnswerWhenAddingTwoNumbers()
    {
        Assert.True(SimpleQuiz.IsRightAnswer(300, Number1 + Number2));
    }

    [Fact]
    public void WrongAnswerWhenAddingTwoNumbers()
    {
        Assert.False(SimpleQuiz.IsRightAnswer(500, Number1 + Number2));
    }
}
