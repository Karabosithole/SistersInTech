import 'package:flutter/material.dart';

class FAQScreen extends StatelessWidget {
  const FAQScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text('Frequently Asked Questions'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            FAQItem(
              question: 'Can I use my card outside South Africa?',
              answer: 'Your Mukuru Card only works within South Africa and the online '
                  'shopping feature can only be used for online stores in South Africa.',
            ),
            FAQItem(
              question: 'Can I change my ID document in future and how?',
              answer: 'Yes you can by visiting a Mukuru Agent or branch with your new ID document. '
                  'Alternatively, you can email the document to verificationsupport@mukuru.com.',
            ),
            FAQItem(
              question: 'Can anyone sign up for a Mukuru account?',
              answer: 'Yes! Anyone who is 18 years and older can set up an account. '
                  'Contact our call centre on 086 001 8555 or dial *130*567# and our friendly staff will help you to sign up.',
            ),
            FAQItem(
              question: 'Can I add my mom to my Funeral Benefit as well?',
              answer: 'Mukuru’s free Funeral Benefit will only pay-out in the event that the sender passes away, it does not cover family members but will pay out to the beneficiary that the sender listed. '
                  'The beneficiary must live in South Africa. However, Mukuru does have Funeral Cover options available for customers that can cover your extended family.',
            ),
            FAQItem(
              question: 'Can I use my friend’s Mukuru account?',
              answer: 'Unfortunately not. To ensure our high standards of security are maintained, we will never allow anyone else to use '
                  'someone else’s account. To help us maintain the highest security standards, please take a couple of minutes to establish ',
            ),
            FAQItem(
              question: 'Card Unblock: How do I reset my 4 digit Card PIN?',
              answer: 'To reset, email a clear photo of yourself holding the  photo page of your ID document  to navsupport@mukuru.com.',
            ),
            FAQItem(
              question: 'Do I still need to pay for premiums for my Mukuru Cover if I have the Mukuru Benefit?',
              answer: 'Yes, you do. Mukuru’s Funeral Benefit is an added free benefit for the use of the Mukuru Card. If you want to be covered, you can sign up for Mukuru’s '
                  'Funeral Cover which will ensure your family and yourself are fully covered in the event of an unexpected loss.',
            ),
            FAQItem(
              question: 'Can I use my Mukuru Card to pay bills?',
              answer: 'Yes, Mukuru Card can be used to make payments for various services, such as utility bills, through a bank or online payment platform that accepts the card.',
            ),
            FAQItem(
              question: 'Where can I get more information about Mukuru?',
              answer: 'For more information, visit our website at www.mukuru.com or contact our customer support team.',
            ),
          ],
        ),
      ),
    );
  }
}

class FAQItem extends StatelessWidget {
  final String question;
  final String answer;

  const FAQItem({
    required this.question,
    required this.answer,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: ExpansionTile(
        title: Text(question, style: const TextStyle(fontWeight: FontWeight.bold)),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(answer),
          ),
        ],
      ),
    );
  }
}
