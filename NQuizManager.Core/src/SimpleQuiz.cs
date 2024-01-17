namespace NQuizManager.Core;

public class SimpleQuiz
{
    public static bool IsRightAnswer(int userAnswer, int rightAnswer)
    {
        return userAnswer == rightAnswer;
    }
}
