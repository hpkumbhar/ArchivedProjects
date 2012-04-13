//
//  NSStream+Synapse.m
//  SynapseClientLibrary
//
//  Created by Roth on 8/19/10.
//  Copyright 2010 Roozy. All rights reserved.
//

#import "NSStream+Synapse.h"

@implementation NSStream (Synapse)

+ (void)getStreamsToHostNamed:(NSString *)hostName port:(NSInteger)port inputStream:(NSInputStream **)inputStream outputStream:(NSOutputStream **)outputStream
{
    CFHostRef           host;
    CFReadStreamRef     readStream;
    CFWriteStreamRef    writeStream;
	
    readStream = NULL;
    writeStream = NULL;
    
    host = CFHostCreateWithName(NULL, (CFStringRef) hostName);
    if (host != NULL) {
        (void) CFStreamCreatePairWithSocketToCFHost(NULL, host, port, &readStream, &writeStream);
        CFRelease(host);
    }
    
    if (inputStream == NULL) {
        if (readStream != NULL) {
            CFRelease(readStream);
        }
    } else {
        *inputStream = [(NSInputStream *) readStream autorelease];
    }
    if (outputStream == NULL) {
        if (writeStream != NULL) {
            CFRelease(writeStream);
        }
    } else {
        *outputStream = [(NSOutputStream *) writeStream autorelease];
    }
}

@end
