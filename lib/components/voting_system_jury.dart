import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VotingSystemJury extends StatefulWidget {
  final String projectId;
  final int currentPoints;
  final int votesCount;

  const VotingSystemJury({
    required this.projectId,
    required this.currentPoints,
    required this.votesCount,
    Key? key,
  }) : super(key: key);

  @override
  State<VotingSystemJury> createState() => _VotingSystemJuryState();
}

class _VotingSystemJuryState extends State<VotingSystemJury> {
  bool hasVoted = false;
  final _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    _checkIfVoted();
  }

  Future<void> _checkIfVoted() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      hasVoted = prefs.getBool('voted_${widget.projectId}') ?? false;
    });
  }

  Future<void> _handleVote() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      
      if (!hasVoted) {
        // Update Firestore
        await _firestore.collection('submissions').doc(widget.projectId).update({
          'points': FieldValue.increment(10),
          'votesCount': FieldValue.increment(1),
        });

        // Mark as voted locally
        await prefs.setBool('voted_${widget.projectId}', true);
        
        setState(() {
          hasVoted = true;
        });

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Vote recorded! +10 points'),
              backgroundColor: Colors.green,
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error recording vote: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Vote Button
        IconButton(
          icon: Icon(
            hasVoted ? Icons.star : Icons.star_border,
            color: hasVoted 
              ? Color.fromARGB(255, 206, 205, 195)
              : Color.fromARGB(255, 158, 158, 151),
            size: 28,
          ),
          onPressed: hasVoted ? null : _handleVote,
        ),
        
        // Points and Votes Counter
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${widget.currentPoints} points',
              style: TextStyle(
                color: Color.fromARGB(255, 206, 205, 195),
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '${widget.votesCount} votes',
              style: TextStyle(
                color: Color.fromARGB(255, 158, 158, 151),
                fontSize: 14,
              ),
            ),
          ],
        ),
      ],
    );
  }
}