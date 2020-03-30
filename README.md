# zindi-iclr-crop-disease
ICLR Workshop Challenge, CGIAR Computer Vision for Crop Disease

13th place submission (originally), by mlandry.
This competition was a valuable lesson in training deep learning models, and in reproducible FastAI submissions.
Unfortunately, I have now learned that setting seeds within my notebook server is insufficient to create an identical submission, for several reasons.

So what appears is what I did, documented fairly reasonably in notebooks, with a couple inconvenient transition files in R to straighten out things I didn't get right in python (just started learning). All the original submissions are present, and the ensembling code is straightforward. However, if you rerun these notebooks, top to bottom, they will not produce the same result. They ought to be somewhat close due to the blending of 10 submissions, but the best was heavily skewed toward the top 4, so if you get a bad seed on those 4, it's possible that it would be far worse.

This is what I'll follow to try and learn all the things that need to happen: 
[FastAI thread](https://forums.fast.ai/t/solved-reproducibility-where-is-the-randomness-coming-in/31628/22)

Which covers a bit more than needed in just the [FastAI documentation](https://docs.fast.ai/dev/test.html#getting-reproducible-results) if I'm reading it right.

* PYTHONHASHSEED has to be set prior to jupyter/kernel start
* Set workers to 1 or 0 (I used 8)
* Set the seed in the several places mentioned in this convenient function:
```
def random_seed(seed_value, use_cuda):
    np.random.seed(seed_value) # cpu vars
    torch.manual_seed(seed_value) # cpu  vars
    random.seed(seed_value) # Python
    if use_cuda: 
        torch.cuda.manual_seed(seed_value)
        torch.cuda.manual_seed_all(seed_value) # gpu vars
        torch.backends.cudnn.deterministic = True  #needed
        torch.backends.cudnn.benchmark = False
```

I was using this competition to learn FastAI early on. I reached a stopping point, a bit too early. And steveoni's comment with about a week to go and associated notebook prompted me to try again. He used a similar FastAI approach and his notebook immediately showed me where I was going wrong: I was giving up too early. I would train for several rounds, usually in 3/4 epochs at a time, and wind up with 10-15 total epochs. steveoni had his set to 40 rounds from the start, and the pattern looked somewhat scary to me. I needed some reminding of just how noisy validation can be from epoch to epoch, and seeing steveoni's notebook continue training after three epochs of worsening results, just to land at a good final spot was very enlightening. So in the last five days of the competition, I started training a variety of deep learning models. You can see them in the [Wiki table](https://github.com/mlandry22/zindi-iclr-crop-disease/wiki), as well as their public and private scores. I didn't copy his notebook code, as I had my own, but I did use his transformations, and also played with mixup, plus trying harder with longer training rounds. These produced improved results from where I was previously at almost immediately.

A few days into doing this (i.e. 2-3 days before the competition ended), I re-read the discussion and noticed a comment about the seed. I tested my own version, and realized it wasn't set properly. You can see this comment started to be left in my notebooks. I did some research on FastAI and noticed that there are several things you have to do: set the seed in multiple places including when you start the notebook, but also within a couple parts of the code, and important--not use the multi-core transformers (I've used `num_workers=8` in all of these). I had too little time left after realizing this. I could have experimented with trying it, but I did not. I'll be sure to do so in the future, but there were too many models I wanted to train/retrain with these settings to be able to redo them all.

So it's something to learn. I'm not in the Zindi points zone anyway, and without steveoni's help, I would not have been near the Top 20 anyway, so I can't feel too bad if I fall out. I imagine that many people are not doing this right, as it's tempting to just dig in with the FastAI notebooks and start working.
